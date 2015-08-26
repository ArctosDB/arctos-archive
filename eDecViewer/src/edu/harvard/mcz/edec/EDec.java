// Warning: Do not regenerate.
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.01.24 at 12:44:09 PM EST 
//
/** EDec.java
 * edu.harvard.mcz.edec
 * 
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
 * 
 * Warning: Do not regenerate with JAXB from schema.
 */
package edu.harvard.mcz.edec;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for eDec complex type.
 * 
 * The edec tilde and pipe separated serialization is the normative serialization.
 * This class (and the Core and Species classes) was started by describing the
 * edec format in an XML schema and generating these classes from it.  An easy
 * ability to serialze as XML is a side consequence of this.  It hasn't been 
 * removed as it could be of utility in the future.  
 * 
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="eDec">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="CoreFields" type="{http://www.example.org/eDecXMLSchema}Core"/>
 *         &lt;element name="SpeciesFields" type="{http://www.example.org/eDecXMLSchema}Species" maxOccurs="unbounded"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "eDec", propOrder = {
    "coreFields",
    "speciesFields"
})
public class EDec {

	public static final String blankDocument = "~~~~S~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |\n" +
			                                   "~~~~~~~~~~~|" +
			                                   "~~~~~~~~~~~";
	
    @XmlElement(name = "CoreFields", required = true)
    protected Core coreFields;
    @XmlElement(name = "SpeciesFields", required = true)
    protected List<Species> speciesFields;

    /** Default constructor.
     * 
     */
    public EDec() {
    	speciesFields = new ArrayList<Species>();
    	parse(EDec.blankDocument);
    	speciesFields.remove(0);
    	speciesFields.remove(0);
    }
    
	/**
	 * Construct an EDec instance from an eDec document.
	 * 
	 * @param eDecDocument
	 */
	public EDec(String eDecDocument) { 
    	speciesFields = new ArrayList<Species>();
		parse(eDecDocument);
	}    
    
	/**
	 * Serialize an EDec instance to an eDec document.
	 * 
	 * @return string containing the eDec formatted serialization.
	 */
	public String toEDecDocument() { 
		StringBuffer result = new StringBuffer();
		result.append(coreFields.toEDecLine()).append("|\n");
		Iterator<Species> i = getSpeciesFields().iterator();
		while (i.hasNext()) { 
			result.append(i.next().toEDecLine());
			if (i.hasNext()) { 
				result.append("|\n");  // End all lines but the last with a pipe.
			}
		}
		result.append("\n");
		return result.toString();
	}
	
	/**
	 * Serialize Species list in an EDec instance to a csv fle.
	 * 
	 * @return string containing the csv serialization.
	 */
	public String toCSV() { 
		StringBuffer result = new StringBuffer();
		Iterator<Species> i = getSpeciesFields().iterator();
		while (i.hasNext()) { 
			result.append(i.next().toCSVLine());
			result.append("\n");  
		}
		return result.toString();
	}	
	
	/**
	 * Populate fields with values from an eDecDocument 
	 * 
	 * @param eDecDocument
	 */
	public void parse(String eDecDocument) { 
		String[] lines = eDecDocument.split("\\|");
		if (lines.length>1) { 
			// Valid 
			coreFields = new Core(lines[0]);
			for (int i=1; i<lines.length; i++) { 
				speciesFields.add(new Species(lines[i]));
			}
		} else { 
			// Invalid eDec, must have at least core and one species line.
		}
	}
    

    
    /**
     * Gets the value of the coreFields property.
     * 
     * @return
     *     possible object is
     *     {@link Core }
     *     
     */
    public Core getCoreFields() {
        return coreFields;
    }

    /**
     * Sets the value of the coreFields property.
     * 
     * @param value
     *     allowed object is
     *     {@link Core }
     *     
     */
    public void setCoreFields(Core value) {
        this.coreFields = value;
    }

    /**
     * Gets the value of the speciesFields property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the speciesFields property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getSpeciesFields().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Species }
     * 
     * 
     */
    public List<Species> getSpeciesFields() {
        if (speciesFields == null) {
            speciesFields = new ArrayList<Species>();
        }
        return this.speciesFields;
    }
    
    public void resetSpeciesFields() { 
        speciesFields = null;
        speciesFields = new ArrayList<Species>();
    }

}