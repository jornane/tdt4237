package no.ntnu.idi.tdt4237.h2012.g5.lut;

import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
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
		expires.put(new Date(), email);
		UUID result = uuids.get(email);
		if (result != null) {
			garbageCollect();
			if (expires.containsValue(email))
				return result;
		}
		uuids.put(email, result = UUID.randomUUID());
		return result;
	}
	
	protected void garbageCollect() {
		Date ceiling = new Date();
		ceiling.setTime(ceiling.getTime()-lifetime);
		for(Entry<Date,String> e : expires.headMap(ceiling).entrySet()) {
			uuids.remove(e.getValue());
			expires.remove(e.getKey());
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
	
	public static void main(String... args) throws InterruptedException {
		ValidationService service = new ValidationService(1);
		String code1 = service.getActivationCode("yorinad@stud.ntnu.no").toString();
		String code2 = service.getActivationCode("yorinad@stud.ntnu.no").toString();
		Thread.sleep(3000);
		String code3 = service.getActivationCode("yorinad@stud.ntnu.no").toString();
		System.out.println(code1);
		System.out.println(code2);
		System.out.println(code3);
	}

}
