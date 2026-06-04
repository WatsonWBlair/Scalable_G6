'''Imports'''
import pandas as pd
from utils.descretizer import discretize
from utils.hotOne import encode



def getClassifierData():
    
    columnsToDrop = ['flightnum','tailnum']
    # columnsToDrop = ['actualelapsedtime', 'flightnum', 'deptime','tailnum']
    '''
    Dropping `flightnum` and 'tailnum' as a statistically irrelevant features.

    `actualelapsedtime` and `deptime` are signifigant predictors because they can be used to directly calculate if the plane was delayed.
    '''

    discretizeFeatures = {
            'distance': ['brief','short','middling','long'],
        }

    oneHotCols = ['dest', 'origin', 'uniquecarrier', 'distance', 'dayofweek']

    rawData = pd.read_csv('./queryResults/samples.csv')
    cleanData = rawData.copy(deep=True)

    cleanColumns = [col.split('.')[1] for col in rawData.columns]
    cleanData.columns = cleanColumns

    # Drop Extranious Columns
    cleanData = cleanData.drop(columns=columnsToDrop)

    cleanData = discretize(cleanData, discretizeFeatures)
    # cleanData = encode(cleanData,oneHotCols)
    cleanData = pd.get_dummies(cleanData, columns=[col for col in oneHotCols if col in cleanData.columns], drop_first=True)


    return cleanData.drop('delayed', axis=1), cleanData['delayed']
