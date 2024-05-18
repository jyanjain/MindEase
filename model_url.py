from fastapi import FastAPI, HTTPException
from main_DecisionTree import predict_phobia
from pydantic import BaseModel
from typing import List

app = FastAPI()

class InputData(BaseModel):
    user_answers: List[int]

# Enable CORS and handle OPTIONS requests
@app.middleware("http")
async def add_cors_header(request, call_next):
    response = await call_next(request)
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    return response

@app.options("/predict")
async def options_predict():
    return {"message": "Allow: POST, OPTIONS"}

@app.post("/predict")
def predict(data: InputData):
    prediction_result = predict_phobia(data.user_answers)
    return {"phobia_prediction": prediction_result}







# from fastapi import FastAPI
# from main_DecisionTree import predict_phobia
# from pydantic import BaseModel
# from typing import List

# app = FastAPI()

# class InputData(BaseModel):
#     user_answers: List[int]

# @app.post("/predict")
# def predict(data: InputData):
#     prediction_result = predict_phobia(data.user_answers)
#     return {"phobia_prediction": prediction_result}












#### Ngrok
# to start the fastapi server
        # uvicorn model_url:app --reload
# Ngrok
        # ngrok http 8000
# then will get the url link 
#       /predict


##### Uvicorn Host
##IP address 
    # 192.168.0.113
# to start the fastapi server
#        uvicorn model_url:app --reload --host 192.168.0.113
# api url
#        http://192.168.0.113:8000/predict

##### My Device
# to start the fastapi server
#         uvicorn model_url:app --reload
# api url
#         http://127.0.0.1:8000/predict


#### Body
# {
#     "user_answers": [0, 1, 1, 1, 0, 1, 1, 0, 1, 1]
# }