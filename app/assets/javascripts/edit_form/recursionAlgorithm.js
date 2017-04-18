function recursionAlgorithm() {
	var currentRemainingFees = 0;
	var currentBpMarkUp = parseFloat(defaultBasisPoints.value);
	var currentPerItemFee = parseFloat(defaultPerItemFee.value);
	var totalTransactions = setTotalVmdTransactions();
	var totalVmdVolume = setTotalVmdVolume();
	var oneBpDollarValue = totalVmdVolume * 0.0001;

	while (currentBpMarkUp < 25 && totalVmdVolume < 15000 ){
		currentBpMarkUp += 1;
		currentPerItemFee -= (oneBpDollarValue / totalTransactions);
	};

	while (currentBpMarkUp < 20 && totalVmdVolume < 20000 ){
		currentBpMarkUp += 1;
		currentPerItemFee -= (oneBpDollarValue / totalTransactions);
	};

	while (currentBpMarkUp < 15 && totalVmdVolume < 40000 ){
		currentBpMarkUp += 1;
		currentPerItemFee -= (oneBpDollarValue / totalTransactions);
	};

	while (currentBpMarkUp < 10 && totalVmdVolume < 100000 ){
		currentBpMarkUp += 1;
		currentPerItemFee -= (oneBpDollarValue / totalTransactions);
	};

	while (currentBpMarkUp < 5) {
		currentBpMarkUp += 1;
		currentPerItemFee -= (oneBpDollarValue / totalTransactions);
	};

	generateAlertMessage(currentPerItemFee, currentBpMarkUp, totalVmdVolume);

	defaultBasisPoints.value = currentBpMarkUp.toFixed(0);
	
	if (currentPerItemFee < 0.05){
		defaultPerItemFee.value = currentPerItemFee.toFixed(3);
	} else {
		defaultPerItemFee.value = currentPerItemFee.toFixed(2);
	};

};