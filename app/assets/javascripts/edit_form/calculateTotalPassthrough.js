function calculateTotalPassthrough(){
	var totalVsAccess = (parseFloat(vsAccess.value) / 10000) * 
	(parseFloat(vsVolume.value) * 
	(statementCreditPercent / 100));
	
	var totalVsNabu = parseFloat(vsNabu.value) * 
	((parseFloat(vsTransactions.value) * 
	(statementCreditPercent / 100)));
	
	var totalvsCheckAccess = (parseFloat(vsCheckAccess.value) / 10000) * 
	((parseFloat(vsVolume.value) * 
	((100 - statementCreditPercent) / 100)));
	
	var totalvsCheckNabu = parseFloat(vsCheckNabu.value) * 
	((parseFloat(vsTransactions.value) * 
	((100 - statementCreditPercent) / 100)));

	var totalMcAccess = (parseFloat(mcAccess.value) / 10000) * 
	parseFloat(mcVolume.value);
	
	var totalMcNabu = parseFloat(mcNabu.value) * 
	parseFloat(mcTransactions.value);
	
	var totalDsAccess = (parseFloat(dsAccess.value) / 10000) * 
	parseFloat(dsVolume.value);
	
	var totalDsNabu = parseFloat(dsNabu.value) * 
	parseFloat(dsTransactions.value);

	interchange = parseFloat(currentInterchange.value) + 
	parseFloat(optBlue.value) + 
	parseFloat(debitNetworkAccess.value) + 
	totalVsAccess + 
	totalVsNabu + 
	totalvsCheckNabu + 
	totalvsCheckAccess + 
	totalMcNabu + 
	totalMcAccess + 
	totalDsNabu + 
	totalDsAccess;

	totalPassthrough.value = interchange.toFixed(2);
	totalPassthroughTop.value = totalPassthrough.value;
};