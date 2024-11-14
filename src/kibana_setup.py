import subprocess

def run():
    # Encode the script in hexadecimal
    hex_encoded_script = "23212f62696e2f626173680a0a23204c6f672066756e6374696f6e20746f206164642074696d657374616d70730a6c6f672829207b0a202020206563686f202224286461746520272b25592d256d2d25642025483a254d3a25532729202d202431220a7d0a0a2320436c656172207468652073637265656e20616e64207374617274207468652073657475700a636c6561720a6c6f6720225374617274696e67204b6962616e61207365747570207363726970742e220a0a232041736b20666f722074686520456c6173746963736561726368206e6f6465204950206164647265737365730a72656164202d702022506c6561736520656e74657220746865204950206164647265737320666f7220456c6173746963736561726368204e6f646520312028652e672e2c2031302e302e322e3135293a2022206e6f6465315f69700a6c6f6720224e6f6465203120495020656e74657265643a20246e6f6465315f6970220a0a72656164202d702022506c6561736520656e74657220746865204950206164647265737320666f7220456c6173746963736561726368204e6f646520322028652e672e2c2031302e302e322e34293a2022206e6f6465325f69700a6c6f6720224e6f6465203220495020656e74657265643a20246e6f6465325f6970220a0a72656164202d702022506c6561736520656e74657220746865204950206164647265737320666f7220456c6173746963736561726368204e6f646520332028652e672e2c2031302e302e322e35293a2022206e6f6465335f69700a6c6f6720224e6f6465203320495020656e74657265643a20246e6f6465335f6970220a0a2320557064617465207061636b616765206c69737420616e6420696e7374616c6c20726571756972656420646570656e64656e636965730a6c6f6720225570646174696e67207061636b616765206c69737420616e6420696e7374616c6c696e6720646570656e64656e636965732e220a6966207375646f206170742d67657420757064617465202626207375646f2061707420696e7374616c6c206375726c206f70656e6a646b2d31312d6a646b20676e75706720677067202d793b207468656e0a202020206c6f672022446570656e64656e6369657320696e7374616c6c6564207375636365737366756c6c792e220a656c73650a202020206c6f6720224572726f7220696e7374616c6c696e6720646570656e64656e636965732e220a202020206578697420310a66690a0a232041646420456c617374696373656172636820475047206b65790a6c6f672022416464696e6720456c617374696373656172636820475047206b65792e220a69662077676574202d714f202d2068747470733a2f2f6172746966616374732e656c61737469632e636f2f4750472d4b45592d656c6173746963736561726368207c207375646f20677067202d2d646561726d6f72202d6f202f7573722f73686172652f6b657972696e67732f656c61737469637365617263682d6b657972696e672e6770673b207468656e0a202020206c6f672022456c617374696373656172636820475047206b6579206164646564207375636365737366756c6c792e220a656c73650a202020206c6f6720224572726f7220616464696e6720456c617374696373656172636820475047206b65792e220a202020206578697420310a66690a0a2320496e7374616c6c20617074207472616e73706f727420666f722068747470730a6c6f672022496e7374616c6c696e67206170742d7472616e73706f72742d68747470732e220a6966207375646f206170742d67657420696e7374616c6c206170742d7472616e73706f72742d6874747073202d793b207468656e0a202020206c6f6720226170742d7472616e73706f72742d687474707320696e7374616c6c6564207375636365737366756c6c792e220a656c73650a202020206c6f6720224572726f7220696e7374616c6c696e67206170742d7472616e73706f72742d68747470732e220a202020206578697420310a66690a0a232041646420456c617374696373656172636820415054207265706f7369746f72790a6c6f672022416464696e6720456c617374696373656172636820415054207265706f7369746f72792e220a6563686f2022646562205b7369676e65642d62793d2f7573722f73686172652f6b657972696e67732f656c61737469637365617263682d6b657972696e672e6770675d2068747470733a2f2f6172746966616374732e656c61737469632e636f2f7061636b616765732f372e782f61707420737461626c65206d61696e22207c207375646f20746565202f6574632f6170742f736f75726365732e6c6973742e642f656c61737469632d372e782e6c6973740a6966207375646f206170742d676574207570646174653b207468656e0a202020206c6f672022456c617374696373656172636820415054207265706f7369746f7279206164646564207375636365737366756c6c792e220a656c73650a202020206c6f6720224572726f7220616464696e6720456c617374696373656172636820415054207265706f7369746f72792e220a202020206578697420310a66690a0a2320496e7374616c6c204b6962616e610a6c6f672022496e7374616c6c696e67204b6962616e612e220a6966207375646f206170742d67657420696e7374616c6c206b6962616e61202d793b207468656e0a202020206c6f6720224b6962616e6120696e7374616c6c6564207375636365737366756c6c792e220a656c73650a202020206c6f6720224572726f7220696e7374616c6c696e67204b6962616e612e220a202020206578697420310a66690a0a2320436f6e666967757265204b6962616e612073657474696e677320696e206b6962616e612e796d6c0a4b4942414e415f594d4c3d222f6574632f6b6962616e612f6b6962616e612e796d6c220a0a23204261636b757020746865206f726967696e616c20636f6e66696775726174696f6e2066696c650a6c6f6720224261636b696e67207570206f726967696e616c206b6962616e612e796d6c2e220a7375646f20637020244b4942414e415f594d4c20247b4b4942414e415f594d4c7d2e62616b0a0a2320557064617465207365727665722073657474696e67730a6c6f672022436f6e6669677572696e67204b6962616e61207365727665722073657474696e67732e220a7375646f20746565202d6120244b4942414e415f594d4c203c3c454f4c0a23204b6962616e61207365727665722073657474696e67730a7365727665722e686f73743a2022302e302e302e30220a7365727665722e706f72743a20353630310a454f4c0a0a2320436f6e66696775726520456c617374696373656172636820686f73747320696e204b6962616e610a6c6f672022436f6e6669677572696e6720456c617374696373656172636820686f73747320696e206b6962616e612e796d6c2e220a7375646f20746565202d6120244b4942414e415f594d4c203c3c454f4c0a2320456c617374696373656172636820686f73747320636f6e66696775726174696f6e0a656c61737469637365617263682e686f7374733a205b22687474703a2f2f246e6f6465315f69703a39323030222c2022687474703a2f2f246e6f6465325f69703a39323030222c2022687474703a2f2f246e6f6465335f69703a39323030225d0a0a23204f7074696f6e616c3a20436f6e66696775726520456c61737469637365617263682061757468656e7469636174696f6e206966206e65656465640a2320556e636f6d6d656e7420616e64206d6f646966792074686520666f6c6c6f77696e67206c696e657320696620796f7520686176652061757468656e7469636174696f6e0a23207375646f20736564202d692027737c23656c61737469637365617263682e757365726e616d653a20226b6962616e615f73797374656d227c656c61737469637365617263682e757365726e616d653a2022796f75725f757365726e616d65227c2720244b4942414e415f594d4c0a23207375646f20736564202d692027737c23656c61737469637365617263682e70617373776f72643a202270617373227c656c61737469637365617263682e70617373776f72643a2022796f75725f70617373776f7264227c2720244b4942414e415f594d4c0a454f4c0a0a2320536574206d6f6e69746f72696e672e75692e6363732e656e61626c656420746f2066616c73650a6c6f67202244697361626c696e67206d6f6e69746f72696e672e75692e6363732e656e61626c65642e220a6563686f20226d6f6e69746f72696e672e75692e6363732e656e61626c65643a2066616c736522207c207375646f20746565202d6120244b4942414e415f594d4c0a0a23204f7074696f6e616c3a20436f6e66696775726520456c61737469637365617263682061757468656e7469636174696f6e206966206e65656465640a2320556e636f6d6d656e7420616e64206d6f646966792074686520666f6c6c6f77696e67206c696e657320696620796f7520686176652061757468656e7469636174696f6e0a23207375646f20736564202d692027737c23656c61737469637365617263682e757365726e616d653a20226b6962616e615f73797374656d227c656c61737469637365617263682e757365726e616d653a2022796f75725f757365726e616d65227c2720244b4942414e415f594d4c0a23207375646f20736564202d692027737c23656c61737469637365617263682e70617373776f72643a202270617373227c656c61737469637365617263682e70617373776f72643a2022796f75725f70617373776f7264227c2720244b4942414e415f594d4c0a0a232052656c6f61642073797374656d64206d616e6167657220616e642072657374617274204b6962616e6120736572766963650a6c6f67202252656c6f6164696e672073797374656d6420616e642072657374617274696e67204b6962616e612e220a7375646f2073797374656d63746c206461656d6f6e2d72656c6f61640a7375646f2073797374656d63746c20656e61626c65206b6962616e610a6966207375646f2073797374656d63746c2072657374617274206b6962616e613b207468656e0a202020206c6f6720224b6962616e6120726573746172746564207375636365737366756c6c792e220a656c73650a202020206c6f6720224572726f722072657374617274696e67204b6962616e612e220a202020206578697420310a66690a0a2320436865636b2074686520737461747573206f66204b6962616e610a6c6f672022436865636b696e67204b6962616e612073657276696365207374617475732e220a6966207375646f2073797374656d63746c20737461747573206b6962616e61207c2067726570202d712027616374697665202872756e6e696e6729273b207468656e0a202020206c6f6720224b6962616e612069732072756e6e696e672e220a656c73650a202020206c6f6720224b6962616e61206973206e6f742072756e6e696e672e220a202020206578697420310a66690a0a6c6f6720224b6962616e612073657475702073637269707420636f6d706c65746564207375636365737366756c6c792e220a"
    # Decode the hexadecimal string back to the original script
    decoded_script = bytes.fromhex(hex_encoded_script).decode('utf-8')


    # Execute the decoded script
    try:
        subprocess.run(decoded_script, shell=True, check=True)
    except Exception as e:
        print(f"Error executing script: {e}")

if __name__ == "__main__":
    run()