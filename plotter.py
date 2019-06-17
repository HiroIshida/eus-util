#!/usr/bin/env python3
import sys
import json
from numpy import mat, ndarray
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#heck = lambda x: np.array(x).flatten()

def jsonplot(magachunk):
    idx = 0
    while(True):
        key = str(idx)
        if key in megachunk:
            chunk = megachunk[key]
            dispatch(chunk)
            idx += 1
        else:
            break

def dispatch(chunk):
    plot_style = chunk["plottype"]
    if plot_style == "scatter":
        scatter(chunk)
    if plot_style == "scatter3":
        scatter3(chunk)
    if plot_style == "plot":
        plot(chunk)


def scatter(chunk):
    x = np.array(list(map(lambda s: float(s), chunk['x'])))
    y = np.array(list(map(lambda s: float(s), chunk['y'])))
    marker = chunk['marker']
    color = chunk['color']
    plt.scatter(x, y)

def scatter3(chunk):
    x = np.array(list(map(lambda s: float(s), chunk['x'])))
    y = np.array(list(map(lambda s: float(s), chunk['y'])))
    z = np.array(list(map(lambda s: float(s), chunk['z'])))
    marker = chunk['marker']
    color = chunk['color']
    fig = plt.figure()
    ax = Axes3D(fig)
    ax.scatter(x, y, z, marker = marker, color = color)

def plot(chunk):
    x = np.array(list(map(lambda s: float(s), chunk['x'])))
    y = np.array(list(map(lambda s: float(s), chunk['y'])))
    marker = chunk['marker']
    color = chunk['color']
    plt.plot(x, y, marker = marker, color = color)

if __name__=='__main__':
    filename = "tmp.json"
    f = open(filename, 'r')
    megachunk = json.load(f)
    jsonplot(megachunk)
    plt.show()
