const transactionList = document.querySelector('.transactionList');
const transactionRows = document.querySelectorAll('.transactionList .transactionRow .transactionItem .row');

var i = 0;
var transactions = [];
for (let row of transactionRows){
    let month, day, vendor, xactionType, amount;
    month = row.querySelector('.dateParts .dateMonth');
    day = row.querySelector('.dateParts .dateDay');
    vendor = row.querySelector('.transactionDescription ');
    xactionType = row.querySelector('.transactionType');
    amount = row.querySelector('.transactionAmount');
    posNeg = amount.querySelector('.vx_h3');
    net = amount.querySelector('.vx_h4');


    transactions[i] ={
        'date':            month.innerHTML+' '+day.innerHTML,
        'vendor':          vendor.innerHTML,
        'xactionType':     xactionType.innerHTML,
        // 'amount':          net.innerHTML
    }

    if (posNeg && net) {
        transactions[i].amount = posNeg.innerHTML + net.innerHTML;
    } else {
        transactions[i].amount = 0;
    }

    i++;
}

let csvContent = "data:text/csv;charset=utf-8,";

transactions.forEach(function(rowArray) {
    let row = rowArray.date + ','+rowArray.vendor+','+rowArray.xactionType+','+rowArray.amount;
    csvContent += row + "\r\n";
});

var encodedUri = encodeURI(csvContent);
window.open(encodedUri);