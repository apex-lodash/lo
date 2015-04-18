public with sharing class lo {
	/** Exception denoting if a key is not found in a collection */
	private class UnknownKeyException extends Exception {}

	/** Message string for if the key is not part of the collection */
	@testVisible private static final String MSG_UNKNOWN_KEY = 'Unknown key ';

	/** Used to enable / disable logging in the class */
	@testVisible private static Boolean LOGGING = false;

	/**
	* If logging for the class is enabled then log the exception
	*
	* @param e The exception to log
	*/
	@testVisible
	private static void logException(Exception e) {
		if (LOGGING) {
			System.debug(System.LoggingLevel.DEBUG, e.getTypeName() + ': ' + e.getMessage());
		}
	}

	/**
	* Recursively follows the map down the path
	*
	* @param collection The map of keys to objects
	* @param The path (dot noted) to traverse to get the information
	* @return The object at the end of the path
	*/
	@testVisible
	private static Object followPath(Map<String, Object> collection, String path) {
		List<String> keys = path.split('\\.', 2);
		String key = keys.get(0);

		if (!collection.containsKey(key)) {
			throw new UnknownKeyException(MSG_UNKNOWN_KEY + key);
		}

		Object data = collection.get(keys.get(0));

		if (keys.size() == 1) {
			return data;
		}

		Map<String, Object> nextCollection = (Map<String, Object>)(data);

		return followPath(nextCollection, keys.get(1));
	}

	/**
	* Plucks data out of a collection of objects
	*
	* @param collection The list of objects to pull from
	* @param path The path (dot noted) to traverse to get the information
	*/
	public static List<Object> pluck(List<Object> collection, String path) {
		List<Object> result = new List<Object>();
		List<Map<String, Object>> rawCollection = new List<Map<String, Object>>();

		for (Object data : collection) {
			try {
				String jsonData = JSON.serialize(data);
				Map<String, Object> untypedCollection = (Map<String, Object>)(JSON.deserializeUntyped(jsonData));
				result.add(followPath(untypedCollection, path));
			} catch (Exception e) {
				logException(e);
			}
		}

		return result;
	}
}