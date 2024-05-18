from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import LabelEncoder
import pandas as pd

df = pd.read_csv('D:/codes/MindEase/all_combinations_with_phobia.csv')

X = df.drop('Phobia', axis=1)
y = df['Phobia']

label_encoder = LabelEncoder()
y = label_encoder.fit_transform(y)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = DecisionTreeClassifier(random_state=42)

model.fit(X_train, y_train)

y_pred = model.predict(X_test)

accuracy = accuracy_score(y_test, y_pred)
print(f"Model Accuracy: {accuracy:.2%}")

def predict_phobia(user_answers):
    user_answers_df = pd.DataFrame([user_answers], columns=df.columns[:-1])
    prediction = model.predict(user_answers_df)[0]
    predicted_label = label_encoder.inverse_transform([prediction])[0]
    return "Yes" if predicted_label == 1 else "No"

user_input = [0, 1, 1, 1, 0, 1, 1, 0, 1, 1]
prediction_result = predict_phobia(user_input)

print(f"Phobia Prediction: {prediction_result}")


