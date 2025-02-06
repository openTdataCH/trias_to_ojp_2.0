import os
from lxml import etree
from xslt_transform import load_xslt, apply_xslt

# Global variable to store the XSLT transform
xslt_transform_request = None
xslt_transform_response = None


def transform_request_xml(xml_data,xslt_transform_request):
    result_data = apply_xslt(xml_data,xslt_transform_request)
    return result_data





# Example usage
if __name__ == '__main__':

    xslt_file_request = './trias_to_ojp2.0_request.xslt'
    xslt_file_response = './trias_to_ojp2.0_response.xslt'

    xslt_transform_request = load_xslt(xslt_file_request)
    xslt_transform_response = load_xslt(xslt_file_response)


    # Create the output folder if it doesn't exist
    if not os.path.exists("output"):
        os.makedirs("output")

    # Get a list of files with 'req' in their filename
    files = [file for file in os.listdir("examples/ojp2.0") if "resp" in file]

    # Send each file to the server and store the result
    for file in files:
        with open("examples/ojp2.0/" + file, "rb") as f:
            data = f.read()
        result = transform_request_xml(data,xslt_transform_response)

        # Create the output filename with 'req' replaced by 'res'
        output_filename = file.replace("resp", "req_trias")
        output_filepath = os.path.join("output", output_filename)

        # Store the result in the output file
        with open(output_filepath, "w", encoding="utf-8") as f:
            f.write(result)
