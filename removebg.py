import requests

def RemoveBg(path, output_path):
    response = requests.post(
        'https://api.remove.bg/v1.0/removebg',
        files={'image_file': open(path, 'rb')},
        data={'size': 'auto'},
        headers={'X-Api-Key': 'oDbm57885KVvB6HfdY8sdQJB'},
    )
    if response.status_code == requests.codes.ok:
        with open(output_path, 'wb') as out:
            out.write(response.content)
    else:
        print("Error:", response.status_code, response.text)


if __name__ == '__main__':
    RemoveBg('profiles/7990187279.jpg', 'profiles/7990187279.png')