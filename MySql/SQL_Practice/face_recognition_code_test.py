pip install face_recognition PIL

import os
import face_recognition
from PIL import Image

def recognize_faces_and_store(image_path, output_folder):
    # Load the image using PIL
    image = face_recognition.load_image_file(image_path)

    # Find the face locations in the image
    face_locations = face_recognition.face_locations(image)

    # Create the output folder if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Process each face in the image
    for i, face_location in enumerate(face_locations):
        # Extract the face from the image
        top, right, bottom, left = face_location
        face_image = image.crop((left, top, right, bottom))

        # Save the face image in the output folder
        face_image.save(os.path.join(output_folder, f'face_{i}.jpg'))

# Example usage
recognize_faces_and_store('input_image.jpg', 'output_folder')



import os

# Get the list of image files in the folder
image_folder = 'input_folder'
image_files = [f for f in os.listdir(image_folder) if f.lower().endswith(('.jpg', '.jpeg', '.png'))]

# Process each image in the folder
for image_file in image