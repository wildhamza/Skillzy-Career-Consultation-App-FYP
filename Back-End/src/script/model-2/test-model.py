import sys
import json
import numpy as np
import joblib
import tensorflow as tf

# Load model, scaler, and label encoder
model = tf.keras.models.load_model("./src/script/model-2/career_model.h5")
scaler = joblib.load("./src/script/model-2/scaler.pkl")
label_encoder = joblib.load("./src/script/model-2/label_encoder.pkl")

# Get input from command line
try:
    input_json = sys.argv[1]
    input_data = json.loads(input_json)

    if not isinstance(input_data, list) or len(input_data) != 27:
        raise ValueError("Input must be a list of 27 elements.")

    # Convert to numpy array and reshape
    input_array = np.array(input_data).reshape(1, -1)

    # Scale input
    input_scaled = scaler.transform(input_array)

    # Predict
    prediction = model.predict(input_scaled)
    predicted_index = np.argmax(prediction)
    predicted_role = label_encoder.inverse_transform([predicted_index])[0]

    print(predicted_role)

except Exception as e:
    print(f"Error: {str(e)}", file=sys.stderr)
    sys.exit(1)
