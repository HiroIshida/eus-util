#!/usr/bin/env python3
import sys
import json
from numpy import mat, ndarray
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#heck = lambda x: np.array(x).flatten()

def jsonplot(magachunk):
    chunk = megachunk['data']['0']
    plot_style = chunk["PLOTTYPE"]
    if plot_style == "scatter":
        scatter(chunk)
    if plot_style == "scatter3":
        scatter3(chunk)
    if plot_style == "plot":
        plot(chunk)

def scatter(chunk):
    x = np.array(list(map(lambda s: float(s), chunk['X'])))
    y = np.array(list(map(lambda s: float(s), chunk['Y'])))
    plt.scatter(x, y)

def scatter3(chunk):
    x = np.array(list(map(lambda s: float(s), chunk['X'])))
    y = np.array(list(map(lambda s: float(s), chunk['Y'])))
    z = np.array(list(map(lambda s: float(s), chunk['Z'])))
    fig = plt.figure()
    ax = Axes3D(fig)
    ax.scatter(x, y, z)

def plot(chunk):
    x = np.array(list(map(lambda s: float(s), chunk['X'])))
    y = np.array(list(map(lambda s: float(s), chunk['Y'])))
    plt.plot(x, y)

if __name__=='__main__':
    filename = "tmp.json"
    f = open(filename, 'r')
    megachunk = json.load(f)
    jsonplot(megachunk)
    plt.show()
