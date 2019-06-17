#!/usr/bin/env python3
import sys
import json
from numpy import mat, ndarray
import numpy as np
import matplotlib.pyplot as plt
#heck = lambda x: np.array(x).flatten()

def jsonplot(magachunk):
    chunk = megachunk['data']['0']
    plot_style = chunk["PLTSTYLE"]
    if plot_style == "scatter":
        scatter(chunk)

def scatter(chunk):
    x = np.array(chunk['X'])
    y = np.array(chunk['Y'])
    plt.scatter(x, y)

if __name__=='__main__':
    filename = "tmp.json"
    f = open(filename, 'r')
    megachunk = json.load(f)
    jsonplot(megachunk)
    plt.show()
