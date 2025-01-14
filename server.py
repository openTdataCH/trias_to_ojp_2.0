import argparse
from flask import Flask, request
import requests
from lxml import etree
from configuration import access_token, ojp20url
from xslt_transform import load_xslt, apply_xslt
app = Flask(__name__)

# Global variable to store the XSLT transform
xslt_transform_request = None
xslt_transform_response = None


@app.route('/', methods=['POST'])
def transform_xml():
    xml_data = request.data.decode('utf-8')
    result_data = apply_xslt(xml_data,xslt_transform_request)

    # Send the transformed result to http://example.com/ojpservice
    headers = {'Authorization': 'Bearer ' + access_token, "User-Agent": "TRIAS2OJP/0.2"}
    response = requests.post(ojp20url, data=result_data.encode('utf-8'),headers=headers)
    result_data= apply_xslt(response.txt,xslt_transform_response)
    return result_data, response.status_code


# Example usage
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=44441, help='Port number to run the server on')
    args = parser.parse_args()

    xslt_file_request = './trias_to_ojp2.0_request.xslt'
    xslt_file_response = './trias_to_ojp2.0_response.xslt'

    xslt_transform_request = load_xslt(xslt_file_request)
    xslt_transform_response = load_xslt(xslt_file_response)

    app.run(port=args.port)