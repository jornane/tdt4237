package no.ntnu.idi.tdt4237.h2012.g5.lut;

import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.TreeMap;
import java.util.UUID;

public class ValidationService {

	final static protected HashMap<Long,ValidationService> INSTANCES = new HashMap<Long,ValidationService>();
	
	protected HashMap<String,UUID> uuids = new HashMap<String,UUID>();
	protected TreeMap<Date,String> expires = new TreeMap<Date,String>(new Comparator<Date>(){
		public int compare(Date o1, Date o2) {
			return o1.compareTo(o2);
		}});
	private long lifetime;
	
	protected ValidationService(long lifetime) {
		this.lifetime = lifetime;
	}
	
	public UUID getActivationCode(String email) {
		UUID result = uuids.get(email);
		if (result != null) {
			garbageCollect();
			if (expires.containsValue(email))
				return result;
		}
		expires.put(new Date(), email);
		uuids.put(email, result = UUID.randomUUID());
		return result;
	}
	
	public boolean checkActivationCode(String email, UUID uuid) {
		UUID result = uuids.get(email);
		if (!uuid.equals(result))
			return false;
		garbageCollect();
		return expires.containsValue(email);
	}
	
	public void invalidate(String email) {
		uuids.remove(email);
	}
	
	protected void garbageCollect() {
		Date ceiling = new Date();
		ceiling.setTime(ceiling.getTime()-lifetime);
		for (
				Iterator<Entry<Date, String>> iterator
					= expires.headMap(ceiling).entrySet().iterator();
				iterator.hasNext();
			) {
			Entry<Date,String> e = iterator.next();
			iterator.remove();
			uuids.remove(e.getValue());
		}
	}
	
	public static ValidationService getInstance(long lifetime) {
		ValidationService instance = INSTANCES.get(lifetime);
		if (instance != null)
			return instance;
		synchronized(INSTANCES) {
			instance = INSTANCES.get(lifetime);
			if (instance != null)
				return instance;
			INSTANCES.put(lifetime, new ValidationService(lifetime));
		}
		return getInstance(lifetime);
	}
	
}
