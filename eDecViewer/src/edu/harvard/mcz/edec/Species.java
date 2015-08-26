/** 
 * Copyright © 2013 President and Fellows of Harvard College
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of Version 2 of the GNU General Public License
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Author: Paul J. Morris
 */
package edu.harvard.mcz.edec;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for Species complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Species">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Genus">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="18"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Species" minOccurs="0">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="18"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Subspecies" minOccurs="0">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="18"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CommonName" minOccurs="0">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="36"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForeignCITES" minOccurs="0">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="30"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="USCITES" minOccurs="0">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="30"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="WildlifeCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="3"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="SourceCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="1"/>
 *               &lt;enumeration value="A"/>
 *               &lt;enumeration value="C"/>
 *               &lt;enumeration value="D"/>
 *               &lt;enumeration value="F"/>
 *               &lt;enumeration value="I"/>
 *               &lt;enumeration value="P"/>
 *               &lt;enumeration value="R"/>
 *               &lt;enumeration value="U"/>
 *               &lt;enumeration value="W"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Quantity" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         &lt;element name="Units">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="2"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Value" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="CountryOfOrigin">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="2"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Species", propOrder = {
    "genus",
    "species",
    "subspecies",
    "commonName",
    "foreignCITES",
    "uscites",
    "wildlifeCode",
    "sourceCode",
    "quantity",
    "units",
    "value",
    "countryOfOrigin"
})
public class Species {

    public static final int GENUS_SIZE = 18;
    public static final int SPECIES_SIZE= 18; 
    public static final int SUBSPECIES_SIZE= 18;
    public static final int COMMONNAME_SIZE= 36;
    public static final int FOREIGNCITES_SIZE= 30;
    public static final int USCITES_SIZE= 30;
    public static final int WILDLIFECODE_SIZE= 3;
    public static final int SOURCECODE_SIZE= 1;
    public static final int QUANTITY_SIZE= 10;
    public static final int UNITS_SIZE= 2;
    public static final int VALUE_SIZE= 10;
    public static final int COUNTRY_SIZE= 2;
    
    public static final String[] SOURCE_CODES = { "A", "C", "D", "F", "I", "P", "R", "U", "W" } ;
	public static final String CSVHEADERLINE = "\"Genus\",\"Species\",\"Subspecies\",\"Common\",\"ForCITES\",\"USCITES\",\"wildlifeCode\",\"sourceCode\",\"quantity\",\"units\",\"valueUSD\",\"CountryOfOrigin\"\n";
	
    @XmlElement(name = "Genus", required = true)
    protected String genus;
    @XmlElement(name = "Species")
    protected String species;
    @XmlElement(name = "Subspecies")
    protected String subspecies;
    @XmlElement(name = "CommonName")
    protected String commonName;
    @XmlElement(name = "ForeignCITES")
    protected String foreignCITES;
    @XmlElement(name = "USCITES")
    protected String uscites;
    @XmlElement(name = "WildlifeCode", required = true)
    protected String wildlifeCode;
    @XmlElement(name = "SourceCode", required = true)
    protected String sourceCode;
    @XmlElement(name = "Quantity")
    protected float quantity;
    @XmlElement(name = "Units", required = true)
    protected String units;
    @XmlElement(name = "Value")
    protected int value;
    @XmlElement(name = "CountryOfOrigin", required = true)
    protected String countryOfOrigin;
    
    /** construct a Species instance from a csv serialization.
     * 
     * @param csvLine
     * @return
     */
    public static Species speciesCSVFactory(String csvLine) { 
    	Species result = new Species();
    	csvLine = csvLine.replace("\"", "");
    	String[] sp = csvLine.split(",");
    	if (sp.length==12) { 
    		// Valid length
    		result.setGenus(sp[0]);
    		result.setSpecies(sp[1]);
    		result.setSubspecies(sp[2]);
    		result.setCommonName(sp[3]);
    		result.setForeignCITES(sp[4]);
    		result.setUSCITES(sp[5]);
    		result.setWildlifeCode(sp[6]);
    		result.setSourceCode(sp[7]);
    		result.setQuantity(sp[8]);
    		result.setUnits(sp[9]);
    		result.setValue(sp[10]);
    		result.setCountryOfOrigin(sp[11]);
    	} 
    	return result;
    }

    /** Default constructor
     * 
     */
    public Species() { 
		setGenus("");
		setSpecies("");
		setSubspecies("");
		setCommonName("");
		setForeignCITES("");
		setUSCITES("");
		setWildlifeCode("SPE");
		setSourceCode("");
		setQuantity(0);
		setUnits("NO");
		setValue(0);
		setCountryOfOrigin("");    	
    }
    
    /** Construct a species instance from a species line in an eDec file.
     * 
     * @param string eDec species line to parse, excluding the pipe character.
     */
    public Species(String eDecSpeciesLine) {
    	String[] sp = eDecSpeciesLine.split("\\~",12);
    	if (sp.length<=12) {
    		try {
    		// Valid length
    		setGenus(sp[0]);
    		setSpecies(sp[1]);
    		setSubspecies(sp[2]);
    		setCommonName(sp[3]);
    		setForeignCITES(sp[4]);
    		setUSCITES(sp[5]);
    		setWildlifeCode(sp[6]);
    		setSourceCode(sp[7]);
    		setQuantity(sp[8]);
    		setUnits(sp[9]);
    		setValue(sp[10]);
    		setCountryOfOrigin(sp[11]);
    		} catch (IndexOutOfBoundsException e) { 
    			// if there are trailing blank fields.
    		}
    	} else { 
    		// incorrect length
    		setGenus("");
    		setSpecies("");
    		setSubspecies("");
    		setCommonName("");
    		setForeignCITES("");
    		setUSCITES("");
    		setWildlifeCode("");
    		setSourceCode("");
    		setQuantity(0);
    		setUnits("NO");
    		setValue(0);
    		setCountryOfOrigin("");    		
    	}
	}

	/** Serialize in the format of a line in an eDec file, not including
     * the trailing pipe character.
     * 
     * @return
     */
	public String toEDecLine() { 
		StringBuffer result = new StringBuffer();
		result.append(genus).append("~");
		result.append(species).append("~");
		result.append(subspecies).append("~");
		result.append(commonName).append("~");
		result.append(foreignCITES).append("~");
		result.append(uscites).append("~");
		result.append(wildlifeCode).append("~");
		result.append(sourceCode).append("~");
		result.append(getQuantityString()).append("~");
		result.append(units).append("~");
		result.append(value).append("~");
		result.append(countryOfOrigin);
		return result.toString();
	}    
	
	/** Serialize in the format of a comma separated values line, not including
     * the trailing end of line character.
     * 
     * @return
     */
	public String toCSVLine() { 
		StringBuffer result = new StringBuffer();
		result.append("\"").append(genus).append("\",\"");
		result.append(species).append("\",\"");
		result.append(subspecies).append("\",\"");
		result.append(commonName).append("\",\"");
		result.append(foreignCITES).append("\",\"");
		result.append(uscites).append("\",\"");
		result.append(wildlifeCode).append("\",\"");
		result.append(sourceCode).append("\",");
		result.append(getQuantityString()).append(",\"");
		result.append(units).append("\",");
		result.append(value).append(",\"");
		result.append(countryOfOrigin).append("\"");
		return result.toString();
	}   	
    
    private String getQuantityString() {
    	String result = "";
    	result = String.format("%d", Math.round(quantity));
		return result;
	}

	/**
     * Gets the value of the genus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGenus() {
        return genus;
    }

    /**
     * Sets the value of the genus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGenus(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	value = value.trim();
    	if (value.length()>Species.GENUS_SIZE) { value = value.substring(0, Species.GENUS_SIZE); }
        this.genus = value;
    }

    /**
     * Gets the value of the species property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSpecies() {
        return species;
    }

    /**
     * Sets the value of the species property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSpecies(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.SPECIES_SIZE) { value = value.substring(0, Species.SPECIES_SIZE); }
        this.species = value;
    }

    /**
     * Gets the value of the subspecies property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSubspecies() {
        return subspecies;
    }

    /**
     * Sets the value of the subspecies property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSubspecies(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.SUBSPECIES_SIZE) { value = value.substring(0, Species.SUBSPECIES_SIZE); }
        this.subspecies = value;
    }

    /**
     * Gets the value of the commonName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCommonName() {
        return commonName;
    }

    /**
     * Sets the value of the commonName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCommonName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.COMMONNAME_SIZE) { value = value.substring(0, Species.COMMONNAME_SIZE); }    	
        this.commonName = value;
    }

    /**
     * Gets the value of the foreignCITES property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForeignCITES() {
        return foreignCITES;
    }

    /**
     * Sets the value of the foreignCITES property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForeignCITES(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.FOREIGNCITES_SIZE) { value = value.substring(0, Species.FOREIGNCITES_SIZE); }
        this.foreignCITES = value;
    }

    /**
     * Gets the value of the uscites property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUSCITES() {
        return uscites;
    }

    /**
     * Sets the value of the uscites property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUSCITES(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.USCITES_SIZE) { value = value.substring(0, Species.USCITES_SIZE); }
        this.uscites = value;
    }

    /**
     * Gets the value of the wildlifeCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWildlifeCode() {
        return wildlifeCode;
    }

    /**
     * Sets the value of the wildlifeCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWildlifeCode(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.WILDLIFECODE_SIZE) { value = value.substring(0, Species.WILDLIFECODE_SIZE); }
        this.wildlifeCode = value;
    }

    /**
     * Gets the value of the sourceCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSourceCode() {
    	String result = "";
    	if (sourceCodeContains(sourceCode)) { 
    		result = sourceCode;
    	}
        return result;
    }

    /**
     * Sets the value of the sourceCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSourceCode(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.SOURCECODE_SIZE) { value = value.substring(0, Species.SOURCECODE_SIZE); }
    	if (sourceCodeContains(value)) { 
            this.sourceCode = value;
    	} else { 
    		this.sourceCode = "";
    	}
    }

    public boolean sourceCodeContains(String value) {
    	boolean result = false; 
    	for (int i=0; i<SOURCE_CODES.length; i++) {
    		try { 
    		   if (value.equals(SOURCE_CODES[i])) { result = true; }
    		} catch (NullPointerException e) { 
    			System.out.println(e.getMessage());
    		}
    	}
    	return result;
    }
    
    /**
     * Gets the value of the quantity property.
     * 
     */
    public float getQuantity() {
        return quantity;
    }

    /**
     * Sets the value of the quantity property.
     * 
     */
    public void setQuantity(float value) {
        this.quantity = value;
    }
    
    public void setQuantity(String value) { 
    	try {
    	    setQuantity(Float.parseFloat(value));
    	} catch (NumberFormatException e) { 
    		this.quantity = 0;
    	}
    }

    /**
     * Gets the value of the units property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUnits() {
        return units;
    }

    /**
     * Sets the value of the units property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUnits(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.UNITS_SIZE) { value = value.substring(0, Species.UNITS_SIZE); }    	
        this.units = value;
    }

    /**
     * Gets the value of the value property.
     * 
     */
    public int getValue() {
        return value;
    }

    /**
     * Sets the value of the value property.
     * 
     */
    public void setValue(int value) {
        this.value = value;
    }

    public void setValue(String value) {
    	try { 
    	    setValue(Integer.parseInt(value));
    	} catch (NumberFormatException e) { 
    		this.value = 0;
    	}
    }
    
    /**
     * Gets the value of the countryOfOrigin property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCountryOfOrigin() {
        return countryOfOrigin;
    }

    /**
     * Sets the value of the countryOfOrigin property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCountryOfOrigin(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Species.COUNTRY_SIZE) { 
    	    // try looking up the country code from the provided string
    		String lookup = new Country().getCodeForCountryName(value);
    		if (lookup!="") { value = lookup; } 
    		value = value.substring(0, Species.COUNTRY_SIZE); 
    	} 
        this.countryOfOrigin = value;
    }

}
