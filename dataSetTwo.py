# -*- coding: utf-8 -*-
"""
Created on Tue Mar 21 17:10:40 2017

@author: Steve
"""
import pandas as pd
import numpy as np
import matplotlib as plt

dsTwo = pd.read_csv(filepath_or_buffer='/home/steve/GitHub/qstate/sampleFeatureMatrix.csv', engine='python')

for i, group in dsTwo.groupby('Concentration1'):
#    plt.figure()
    group.plot(x='Concentration1', y='Feature1')