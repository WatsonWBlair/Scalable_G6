import pandas as pd


def encode(dataFrame: pd.DataFrame, fields: list):
    result = dataFrame.copy()
    newColumns = {}

    for field in fields:
        for _, fieldValue in enumerate(result[field].unique()):
            hotColumn = str(field)+'_'+str(fieldValue)
            newColumns[hotColumn] = result[field].eq(fieldValue)
            newColumns[hotColumn] = [int(value) for value in newColumns[hotColumn]]
        
    newFrame = pd.DataFrame.from_dict(newColumns)
    result = pd.concat([result, newFrame], axis=1)

    toDrop = fields + [str(field)+'_nan' for field in fields]

    result = result.drop(columns=toDrop, errors='ignore')
    return result