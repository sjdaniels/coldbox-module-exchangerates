component output="false"  {

	/**
	* Init
	* @settings.inject coldbox:setting:exchangerateapi
	*/
	public function init(required settings){
		apikey = settings.apiKey;
		return this;
	}

	public numeric function exchange(required numeric amount, required string from, required string to) {
		var cfhttp = {}
		http method="get" url="http://www.exchangerate-api.com/#arguments.from#/#arguments.to#/#abs(arguments.amount)#?k=#apikey#";
		if (val(cfhttp.filecontent) > 0) return val(cfhttp.filecontent);

		if ( isvalid("range",val(cfhttp.filecontent),-5,-1) ) {
			onApiException(cfhttp.filecontent);
		}

		throw(type="ExchangeRates", message="Invalid response from exchangerate API.", detail="The response from exchangerate API was non-numeric.", extendedinfo="#serializeJSON(cfhttp)#");
	}
 
	public any function onApiException(required numeric errorcode) {
		var e = {
			"-1" : "An invalid amount was used (must be numeric floating point or integer numbers)",
			"-2" : "One of the 3 letter currency codes is invalid (Check our supported currencies)",
			"-3" : "An invalid key was used (Get an API key)",
			"-4" : "Monthly API query limit is reached (Click here for extended usage)",
			"-5" : "An unresolvable IP address is provided"
		}

		throw(type="ExchangeRate", message="EchangeRate API Returned Error", detail=e[arguments.errorcode]);
	}

}