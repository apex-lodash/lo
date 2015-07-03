public with sharing class lo {
	/** Exception denoting if a key is not found in a collection */
	@testVisible private class UnknownKeyException extends Exception {}

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
	private static void log(Exception e) {
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
	* Plucks data out of a single object
	*
	* @param obj The object
	* @param path The path (dot noted) to traverse to get the information
	*/
	public static Object pluck(Object obj, String path) {
		String jsonData = JSON.serialize(obj);
		Map<String, Object> untypedCollection = (Map<String, Object>)(JSON.deserializeUntyped(jsonData));
		return followPath(untypedCollection, path);
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
				result.add(pluck(data, path));
			} catch (Exception e) {
				log(e);
			}
		}

		return result;
	}

	/**
	* A utility method for turning a list of Objects into a list of Strings
	*
	* @param collection The collection of objects to iterate over
	* @return A type casted list of strings
	*/
	public static List<String> toString(List<Object> collection) {
		if (collection == null) {
			return null;
		}

		List<String> result = new List<String>();

		for (Object obj : collection) {
			result.add((String)(obj));
		}

		return result;
	}
}