function setTotalFeesIfZero(totalFeesValue, totalVolumeValue, totalTransactionsValue){
	if (totalFeesValue == 0){
		if (totalVolumeValue < 20000){
			totalFees.value = (parseFloat(totalPassthrough.value) + 
			(totalVolumeValue * 0.01) + 
			(totalTransactionsValue * 0.12)).toFixed(2);
		} else if (totalVolumeValue < 50000){
			totalFees.value = (parseFloat(totalPassthrough.value) + 
			(totalVolumeValue * 0.006) + 
			(totalTransactionsValue * 0.08)).toFixed(2);
		} else {
			totalFees.value = (parseFloat(totalPassthrough.value) + 
			(totalVolumeValue * 0.004) + 
			(totalTransactionsValue * 0.07)).toFixed(2);
		}
		$("#totalFeesAlert").removeClass("hidden");
		$("#totalFeesAlert").delay(2000).fadeOut(1000);
	}
}