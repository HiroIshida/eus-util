#!/usr/bin/env python3
import sys
import json
from numpy import mat, ndarray
import numpy as np
import matplotlib.pyplot as plt
#heck = lambda x: np.array(x).flatten()

def jsonplot(megachunk):
    set_generic_properties(megachunk)
    idx=0;
    while str(idx) in megachunk:
        chunk = megachunk[str(idx)]
        plotter(chunk)
        idx+=1
    set_generic_properties(megachunk)

def set_generic_properties(megachunk):
    if 'xlim' in megachunk:
        xlim_lst = megachunk['xlim']
        plt.xlim(xlim_lst)
    if 'ylim' in megachunk:
        ylim_lst = megachunk['ylim']
        plt.ylim(ylim_lst)
    if 'axis' in megachunk:
        plt.axis(megachunk['axis'])

def plotter(chunk):
    pltype = chunk["plot_type"]
    if pltype=='pcolor':
        X = np.array(chunk['X'])
        Y = np.array(chunk['Y'])
        V = np.array(chunk['V'])
        plt.pcolor(X, Y, V)

    elif pltype=='plot':
        x = np.array(chunk['x'])
        y = np.array(chunk['y'])
        style = chunk['plotstyle']
        plt.plot(x, y, style)

    elif pltype=='scatter':
        x = np.array(chunk['x'])
        y = np.array(chunk['y'])
        style = chunk['plotstyle']
        plt.scatter(x, y, style)

if __name__=='__main__':
    filename = "/tmp.json"
    f = open(filename, 'r')
    megachunk = json.load(f)
    jsonplot(megachunk)
    duration = megachunk['duration']
    if duration == 0:
        plt.show()
    else:
plt.pause(duration)
