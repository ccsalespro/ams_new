function calculatePerItemFees(transactions, perItemFee) {
	perItemFees = transactions * perItemFee;
	return perItemFees.toFixed(2)
};

function calculateMarkUpFees(volume, basisPoints) {
	markUpFees = volume * (basisPoints / 10000);
	return markUpFees.toFixed(2);
};

function calculateAvgTicket(volume, transactions) {
	if (volume > 0){
		avgTicket = volume / transactions;
	} else {
		avgTicket = 0;
	}
	return avgTicket.toFixed(2);
};

function calculateTransactions(volume, avgTicket) {
	transactions = volume / avgTicket;
	return transactions.toFixed(0);
};

// Calculate the ratio of 1 penny to 5 basis points.
function calculateRatio(averageTicket){
	var ratio = (averageTicket * 0.0005) / 0.01;
	return ratio;
};
