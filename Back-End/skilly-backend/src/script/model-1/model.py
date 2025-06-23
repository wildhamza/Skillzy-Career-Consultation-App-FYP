import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.utils import class_weight
import numpy as np
import pandas as pd
from sklearn.preprocessing import LabelEncoder

# Load dataset
data = pd.read_csv('../career-mapping.csv')
tf.keras.models
# Preprocess the data
X = data.iloc[:, :-1].values  # Features
y = data.iloc[:, -1].values   # Target

# Encode target labels if not already numerical
label_encoder = LabelEncoder()
y = label_encoder.fit_transform(y)

# Standardize features
scaler = StandardScaler()
X = scaler.fit_transform(X)

# Split dataset
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)

scaler.fit(X_train)  # Fit scaler to training data

# Handle class imbalance using class weights
class_weights = class_weight.compute_class_weight(class_weight='balanced', classes=np.unique(y), y=y_train)
class_weights = {i: weight for i, weight in enumerate(class_weights)}

# Build model
model = tf.keras.models.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(X_train.shape[1],)),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.Dropout(0.3),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.Dropout(0.3),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(len(np.unique(y)), activation='softmax')  # Output layer for multi-class classification
])