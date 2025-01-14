from lxml import etree



def load_xslt(xslt_file):
    global xslt_transform
    with open(xslt_file, 'r') as file:
        xslt_data = file.read()
    xslt_tree = etree.fromstring(xslt_data)
    xslt_transform = etree.XSLT(xslt_tree)
    return xslt_transform

def apply_xslt(xml_data,xslt_transform):
    xml_tree = etree.fromstring(xml_data)
    result_tree = xslt_transform(xml_tree)
    result_data = str(result_tree)
    return result_data


