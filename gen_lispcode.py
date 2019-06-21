# convert a tree structure (nested list) to lisp code
def gen_lispcode(tree): 
    isNode = not(isinstance(tree, list))
    if isNode:
        return tree
    ret = "("
    for sub_tree in tree[:-1]:
        ret = ret + gen_lispcode(sub_tree) + " "
    ret = ret + gen_lispcode(tree[-1]) + ")"
    return ret

def gen_jsondata_lst(method_name, args, kwargs): 
    data = ["list"]
    data.append(["cons", ":plottype", "\"" + method_name + "\""])
    arg_lst = []
    arg_lst.extend(list(args))
    arg_lst.extend(list(kwargs.keys()))
    for arg in arg_lst:
        key_lisp = ":" + arg 
        data.append(["cons", key_lisp, arg])
    return data

def gen_method_def(method_name, args, kwargs):
    data = gen_jsondata_lst(method_name, args, kwargs)
    definition = ["let", [["data", data]],
            ["send", "self", ":add-plot", "data"]]
    return definition

def gen_method_args(args, kwargs):
    arg_lst = list(args)
    arg_lst.append("&key")
    for pair  in kwargs.items(): 
        key = pair[0]
        val = str(pair[1])
        arg_lst.append([key, val])
    return arg_lst

def gen_method(method_name, *args, **kwargs):
    method_args = gen_method_args(args, kwargs)
    method_def = gen_method_def(method_name, args, kwargs)
    method = ["defmethod", "JsonPlotter",
            [":"+ method_name, method_args, method_def]]
    return method

hist = gen_method("hist", "x", bins = 10) 
plot = gen_method("plot", "x", "y", marker = "\"o\"", color = "\"r\"")
scatter = gen_method("scatter", "x", "y", marker = "\"o\"", color = "\"r\"")
scatter3 = gen_method("scatter3", "x", "y", "z", marker = "\"o\"", color = "\"r\"")

f = open("method_generated.lsp", "w")
for method in [hist, plot, scatter, scatter3]:
    lisp_code = gen_lispcode(method)
    f.write(lisp_code)
    f.write("\n\n")
f.close()


