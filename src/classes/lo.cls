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

	/**
	* A method to drop a given number of elements off the "left hand side" of an list
	*
	* @param collection A list of objects to drop from
	* @param n The number of items to drop
	* @return The reduced collection
	*/
	public static List<Object> drop(List<Object> collection, Integer n) {
		if (collection == null || n >= collection.size()) {
			return new List<Object>();
		}

		for (Integer i = 0; i < n; i++) {
			collection.remove(0);
		}

		return collection;
	}

	/**
	* A method to drop a single element off the "left hand side" of an list
	*
	* @param collection A list of objects to drop from
	* @return The reduced collection
	*/
	public static List<Object> drop(List<Object> collection) {
		return drop(collection, 1);
	}

	/**
	* A method to drop a given number of elements off the "right hand side" of an list
	*
	* @param collection A list of objects to drop from
	* @param n The number of items to drop
	* @return The reduced collection
	*/
	public static List<Object> dropRight(List<Object> collection, Integer n) {
		if (collection == null || n >= collection.size()) {
			return new List<Object>();
		}

		for (Integer i = 0; i < n; i++) {
			collection.remove(collection.size() - 1);
		}

		return collection;
	}

	/**
	* A method to drop a single element off the "right had side" of an list
	*
	* @param collection A list of objects to drop from
	* @return The reduced collection
	*/
	public static List<Object> dropRight(List<Object> collection) {
		return dropRight(collection, 1);
	}

	/**
	* A method to generate a filled list of objects
	*
	* @param source The source object
	* @param n The number of times to fill that object
	* @return The populated list
	*/
	public static List<Object> fill(Object source, Integer n) {
		List<Object> result = new List<Object>();

		for (Integer i = 0; i < n; i++) {
			result.add(source);
		}

		return result;
	}

	/**
	* A method to take a single list of objects and chunk it into a list of list of objects
	*
	* @param collection The collection list
	* @param n The number of items per chunk
	* @return The chunked list
	*/
	public static List<List<Object>> chunk(List<Object> collection, Integer n) {
		List<Object> collectionCopy = collection.clone();
		List<List<Object>> result = new List<List<Object>>();

		if (n <= 0) {
			return result;
		}

		List<Object> parts = new List<Object>();
		for (Integer i = 1; i < collection.size() + 1; i++) {
			parts.add(collectionCopy.remove(0));

			if (Math.mod(i, n) == 0) {
				result.add(parts.clone());
				parts.clear();
			}
		}

		if (!parts.isEmpty()) {
			result.add(parts);
		}

		return result;
	}

	/**
	* A method to get the last element of the list
	*
	* @param collection The collection list
	* @return The last element in the list
	*/
	public static Object last(List<Object> collection) {
		if (collection == null || collection.isEmpty()) {
			return null;
		}

		return collection.get(collection.size() - 1);
	}

	/**
	* Gets all of the list except for the first element
	*
	* @param collection The collection list
	* @return All of the list except the first element
	*/
	public static List<Object> rest(List<Object> collection) {
		if (collection == null || collection.isEmpty()) {
			return new List<Object>();
		}

		List<Object> collectionCopy = collection.clone();
		collectionCopy.remove(0);

		return collectionCopy;
	}

	/**
	* Slices out parts of an list from the given start to the given end
	*
	* @param collection The collection list
	* @param start The starting index
	* @param stop The ending index
	* @return The new list
	*/
	public static List<Object> slice(List<Object> collection, Integer start, Integer stop) {
		if (collection == null || collection.isEmpty() || start > stop) {
			return new List<Object>();
		}

		List<Object> collectionCopy = collection.clone();
		List<Object> result = new List<Object>();

		start = (start < 0) ? 0 : start;
		stop = (stop > collectionCopy.size()) ? collectionCopy.size() : stop;

		for (Integer i = start; i < stop; i++) {
			result.add(collectionCopy.remove(start));
		}

		return result;
	}

	/**
	* Slices from the given index to the end of the list
	*
	* @param collection The collection list
	* @param start The starting index
	* @return The new list
	*/
	public static List<Object> slice(List<Object> collection, Integer start) {
		if (collection == null || collection.isEmpty()) {
			return new List<Object>();
		}

		return slice(collection, start, collection.size());
	}

	/**
	* Takes a list of lists and makes them into a single list
	*
	* @param collection The list of lists
	* @return The new list
	*/
	public static List<Object> union(List<List<Object>> collection) {
		List<Object> result = new List<Object>();

		if (collection == null || collection.isEmpty()) {
			return result;
		}

		List<List<Object>> clonedCollection = collection.clone();

		for (List<Object> subCollection : clonedCollection) {
			if (subCollection == null || subCollection.isEmpty()) {
				continue;
			}

			Integer subCollectionSize = subCollection.size();

			for (Integer i = 0; i < subCollectionSize; i++) {
				result.add(subCollection.remove(0));
			}
		}

		return result;
	}

	/**
	* Generates a list of parts from the "left hand side" of the list
	*
	* @param collection The list of objects
	* @param n The number of parts to return
	* @return The new list
	*/
	public static List<Object> take(List<Object> collection, Integer n) {
		return slice(collection, 0, n);
	}

	/**
	* Generates a list of parts from the "right hand side" of the list
	*
	* @param collection The list of objects
	* @param n The number of parts to return
	* @return The new list
	*/
	public static List<Object> takeRight(List<Object> collection, Integer n) {
		if (collection == null) {
			return new List<Object>();
		}

		return slice(collection, collection.size() - n, collection.size());
	}
}