import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, classification_report
from xgboost import XGBClassifier

# Load the dataset
df = pd.read_csv("./queryResults/samples.csv")

# Clean column names (standardize to lowercase and remove prefixes like 'samples.')
df.columns = [col.split('.')[-1].strip().lower() for col in df.columns]
print("✅ Columns in dataset:", df.columns.tolist())

# Confirm target column
if 'delayed' in df.columns:
    target_column = 'delayed'
else:
    raise ValueError("❌ 'delayed' column not found in dataset.")

# Drop missing values
df.dropna(inplace=True)

# Drop non-useful or non-numeric columns
columns_to_drop = ['tailnum', 'flightnum']  # You can add more if needed
df.drop(columns=[col for col in columns_to_drop if col in df.columns], inplace=True)

# Encode categorical variables
categorical_cols = ['uniquecarrier', 'origin', 'dest']
df = pd.get_dummies(df, columns=[col for col in categorical_cols if col in df.columns], drop_first=True)

# Prepare X and y
X = df.drop(columns=[target_column])
y = df[target_column].map({'N': 0, 'Y': 1}) if df[target_column].dtype == object else df[target_column]

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train XGBoost model
model = XGBClassifier(use_label_encoder=False, eval_metric='logloss')
model.fit(X_train, y_train)

# Predict and evaluate
y_pred = model.predict(X_test)

accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)

print("🎯 Accuracy:", round(accuracy * 100, 2), "%")
print("🎯 Precision:", round(precision * 100, 2), "%")
print("\n📊 Classification Report:\n", classification_report(y_test, y_pred))
