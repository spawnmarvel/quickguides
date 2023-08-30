import requests
import base64
import json
username = "pythonWorker"
password = "PythonApp4189Worker"

import requests
import json

# The URL for the API endpoint
url = 'https://follow-e-lo.com/wp-json/wp/v2/posts'

# Your WordPress username
username = 'pythonWorker'

# The application password you generated
password = '6Nxl OFQR p5OC 5KJI g67W kbws'

# The post data
data = {
    'title': 'My New Post Python Steinar',
    'content': 'This is the content of my new post.',
    'status': 'publish'  # Use 'draft' to save the post as a draft
}

# Send the HTTP request
response = requests.post(url, auth=(username, password), json=data)

# Check the response
if response.status_code == 201:
    print('Post created successfully')
else:
    print('Failed to create post: ' + response.text)