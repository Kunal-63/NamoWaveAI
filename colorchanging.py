import replicate

output = replicate.run(
    "naklecha/fashion-ai:4e7916cc6ca0fe2e0e414c32033a378ff5d8879f209b1df30e824d6779403826",
    input={
        "image": "https://replicate.delivery/pbxt/It7YNyAmywNkJXdMzXXsCuc7a6WLYl10nZJ4d2SiZ5NGdsE0/77816-2000x2667-mobile-hd-elon-musk-wallpaper-image.jpg",
        "prompt": "a person wearing blue jeans",
        "clothing": "bottomwear"
    }
)
print(output)