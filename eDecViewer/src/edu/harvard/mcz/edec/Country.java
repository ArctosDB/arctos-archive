package edu.harvard.mcz.edec;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

public class Country {

	private List<CountryAndCode> countries;
	
	public Country() { 
		init();
	}
	
	private void init() { 
		countries = new ArrayList<CountryAndCode>();
		
        String[] countryCodes = Locale.getISOCountries();

        for (int i=0; i<countryCodes.length; i++) { 
        	Locale ctLocale = new Locale("en", countryCodes[i]);
        	countries.add(new CountryAndCode(countryCodes[i],ctLocale.getDisplayCountry()));
        }
	}
	
	public String getCodeForCountryName(String aName) {
		String result = "";
		Iterator<CountryAndCode> i = countries.iterator();
		while (i.hasNext()) { 
			CountryAndCode ct = i.next();
			if (ct.getCountry().equals(aName)) { 
				result = ct.getCode();
			}
		}
		return result;
	}
	
	public List<CountryAndCode> getCountries() { 
		return countries;
	}
	
	public CountryAndCode[] getCountryArray() { 
		CountryAndCode[] result = new CountryAndCode[countries.size()];
		Iterator<CountryAndCode> i = countries.iterator();
		int counter = 0;
		while (i.hasNext()) { 
			result[counter] = i.next();
			counter++;
		}
		return result;
	}
	
	
	public CountryAndCode getObjectForCode(String countryCode) {
        Locale ctLocale = new Locale("", countryCode);
		return new CountryAndCode(countryCode, ctLocale.getDisplayCountry());
	}
	
	public class CountryAndCode { 
		private String country;
		private String code;
		
		public CountryAndCode(String twoLetterCode, String countryName)  {
			country = countryName;
			code = twoLetterCode;
		}
		
		public CountryAndCode() {
			// TODO Auto-generated constructor stub
		}

		public String getCountry() { 
			return country;
		}
		
		public String getCode() { 
			return code;
		}
		
		public String toString() { 
			if (code==null) { 
				return super.toString();
			}
			return code + "-" + country;
		}
	}
}
