var string1 = 'ffff01',
    string2 = 'ffff09';

function getRGB(hex) {

    // slice the string in 3:
    // 2 chars each for the red, green & blue values
    let rgb = {
        'red':   parseInt(hex.slice(0, 2), 16),
        'green':   parseInt(hex.slice(2, 4), 16),
        'blue':   parseInt(hex.slice(4, 6), 16),
    }

    return rgb;
}

function getMean(val1, val2) {

    // make sure we're working with numbers
    if (isNaN(val1) || isNaN(val2)) {
        return false;
    }

    // calculate and return the rounded average of the two numbers
    mean = (val1+val2)/2;
    mean = Math.round(mean);

    return mean;
}

function thatsright(string1, string2){

    // given the hex string, get the red, green & blue values for each
    var rgb1 = getRGB(string1);
    var rgb2 = getRGB(string2);

    var averageColor = '';
    // for each of the 3 colors (red, green, blue)...
    for (let color of ['red','green','blue']){

        // ...get the average of the first string and second string..
        let mean = getMean(rgb1[color], rgb2[color]);

        // ..if it's only 1 digit...
        if (mean < 10) {

            // ...add a leading 0...
            mean = '0' + mean.toString(16)
        }

        // ..convert that to a hex string and append it to the string variable 'averageColor'
        averageColor += mean.toString(16);

    }

    return averageColor;

}

thatsright(string1, string2);