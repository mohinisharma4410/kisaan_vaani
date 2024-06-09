from flask import Flask, request, jsonify
import numpy as np
import pickle
import pandas as pd

app = Flask(__name__)

# Load the saved model
model_filename = r'rf_model.pkl'
with open(model_filename, 'rb') as file:
    model = pickle.load(file)

# Function to get common names for labels
def get_common_name_for_label(input_file, desired_labels):
    df = pd.read_excel(input_file)
    common_names_dict = {}

    for label in desired_labels:
        common_name = df.loc[df['Label'] == label, 'Common Names'].values
        if len(common_name) > 0:
            common_names_dict[label] = common_name[0]

    common_names = [common_names_dict[label] for label in desired_labels if label in common_names_dict]

    return common_names

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    input_features = np.array(data['features']).reshape(1, -1)
    N = 5  # Predefined number of top predictions

    # Predict probabilities
    probs = model.predict_proba(input_features)
    top_n_idx = np.argsort(probs[0])[-N:][::-1]
    top_n_labels = model.classes_[top_n_idx]

    # Get common names for the top N labels
    input_file = 'Crop_common_name.xlsx'  # Update with the correct path to your file
    common_names = get_common_name_for_label(input_file, top_n_labels)

    response = {
        'top_n_labels': top_n_labels.tolist(),
        'common_names': common_names
    }

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
