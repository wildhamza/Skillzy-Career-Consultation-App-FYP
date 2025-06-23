import sys
import json
import tensorflow as tf
import numpy as np
import json
import sys
from model import label_encoder, scaler  # Remove X_train import

input_inner = json.loads(sys.argv[1])
input_data = [input_inner]  # Wrap in a list to match 2D shape

# Scale the input using the pre-fitted scaler (DO NOT re-fit)
input_data_scaled = scaler.transform(input_data)

# Load the model
loaded_model = tf.keras.models.load_model(
    './src/script/model-1/modified_model.h5',
    compile=False,
    custom_objects={'InputLayer': tf.keras.layers.InputLayer}
)
loaded_model.compile(optimizer='adam', loss='categorical_crossentropy')

# Predict and get label
prediction = loaded_model.predict(input_data_scaled)
predicted_label = label_encoder.inverse_transform([np.argmax(prediction)])[0]

print(predicted_label)  # Output only the label
sys.stdout.flush()