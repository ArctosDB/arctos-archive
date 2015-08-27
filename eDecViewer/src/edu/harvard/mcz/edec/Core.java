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

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;



/**
 * <p>Java class for Core complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Core">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ImportExport">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="1"/>
 *               &lt;enumeration value="I"/>
 *               &lt;enumeration value="E"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Port">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="2"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEDate" type="{http://www.w3.org/2001/XMLSchema}date"/>
 *         &lt;element name="IELicense">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;maxLength value="6"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Purpose">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CustomsID">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="Carrier">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="25"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="MasterWaybill">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="25"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="HouseWaybill">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="25"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="TransportationCode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="1"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="AutoLicense">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="10"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="AutoState">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="2"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="BondedLocation">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="25"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CartonCount" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="PackageMarkings">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="25"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEBuisiness">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="60"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IELastName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="30"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEFirstName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEMiddleName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEAddress">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="68"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IECity">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEState">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="2"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEZip">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="5"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEZipPlus4">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="4"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="IEPhone">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="15"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForBuisiness">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="60"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForLastName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="30"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForFirstName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForMiddleName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForAddress">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="68"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForCity">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForCountry">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="2"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="ForPhone">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="15"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CustomsBroker">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="80"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CustomsBrokerPhone">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="15"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CustomsBrokerFax">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="15"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CustomsBrokerLastName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="30"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="CustomsBrokerFirstName">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;length value="20"/>
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
@XmlType(name = "Core", propOrder = {
    "importExport",
    "port",
    "ieDate",
    "ieLicense",
    "purpose",
    "customsID",
    "carrier",
    "masterWaybill",
    "houseWaybill",
    "transportationCode",
    "autoLicense",
    "autoState",
    "bondedLocation",
    "cartonCount",
    "packageMarkings",
    "ieBuisiness",
    "ieLastName",
    "ieFirstName",
    "ieMiddleName",
    "ieAddress",
    "ieCity",
    "ieState",
    "ieZip",
    "ieZipPlus4",
    "iePhone",
    "forBuisiness",
    "forLastName",
    "forFirstName",
    "forMiddleName",
    "forAddress",
    "forCity",
    "forCountry",
    "forPhone",
    "customsBroker",
    "customsBrokerPhone",
    "customsBrokerFax",
    "customsBrokerLastName",
    "customsBrokerFirstName"
})
public class Core {

	public static final int  IMPORTEXPORT_SIZE = 1;
    public static final int  PORT_SIZE = 2;
    public static final int  IEDATE_SIZE = 10 ;
    public static final int  IELICENSE_SIZE = 6 ;
    public static final int  PURPOSE_SIZE = 1 ;
    public static final int  CUSTOMSID_SIZE = 20 ;
    public static final int  CARRIER_SIZE = 25 ;
    public static final int  MASTERWAYBILL_SIZE = 25;
    public static final int  HOUSEWAYBILL_SIZE = 25;
    public static final int  TRANSPORTATIONCODE_SIZE = 1;
    public static final int  AUTOLICENSE_SIZE = 10;
    public static final int  AUTOSTATE_SIZE = 2;
    public static final int  BONDEDLOCATION_SIZE = 25;
    public static final int  CARTONCOUNT_SIZE = 10;
    public static final int  PACKAGEMARKINGS_SIZE = 25;
    public static final int  IEBUISINESS_SIZE = 60;
    public static final int  IELASTNAME_SIZE = 30;
    public static final int  IEFIRSTNAME_SIZE = 20;
    public static final int  IEMIDDLENAME_SIZE = 20;
    public static final int  IEADDRESS_SIZE = 68;
    public static final int  IECITY_SIZE = 20;
    public static final int  IESTATE_SIZE = 2;
    public static final int  IEZIP_SIZE = 5;
    public static final int  IEZIPPLUS4_SIZE = 4 ;
    public static final int  IEPHONE_SIZE = 15;
    public static final int  FORBUISINESS_SIZE = 60;
    public static final int  FORLASTNAME_SIZE = 30;
    public static final int  FORFIRSTNAME_SIZE = 20;
    public static final int  FORMIDDLENAME_SIZE = 20;
    public static final int  FORADDRESS_SIZE = 68;
    public static final int  FORCITY_SIZE = 20;
    public static final int  FORCOUNTRY_SIZE = 2;
    public static final int  FORPHONE_SIZE = 15;
    public static final int  CUSTOMSBROKER_SIZE = 80;
    public static final int  CUSTOMSBROKERPHONE_SIZE = 15;
    public static final int  CUSTOMSBROKERFAX_SIZE = 15;
    public static final int  CUSTOMSBROKERLASTNAME_SIZE = 20;
    public static final int  CUSTOMSBROKERFIRSTNAME_SIZE = 20;
	
    @XmlElement(name = "ImportExport", required = true)
    protected String importExport;
    @XmlElement(name = "Port", required = true)
    protected String port;
    @XmlElement(name = "IEDate", required = true)
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar ieDate;
    @XmlElement(name = "IELicense", required = true)
    protected String ieLicense;
    @XmlElement(name = "Purpose", required = true)
    protected String purpose;
    @XmlElement(name = "CustomsID", required = true)
    protected String customsID;
    @XmlElement(name = "Carrier", required = true)
    protected String carrier;
    @XmlElement(name = "MasterWaybill", required = true)
    protected String masterWaybill;
    @XmlElement(name = "HouseWaybill", required = true)
    protected String houseWaybill;
    @XmlElement(name = "TransportationCode", required = true)
    protected String transportationCode;
    @XmlElement(name = "AutoLicense", required = true)
    protected String autoLicense;
    @XmlElement(name = "AutoState", required = true)
    protected String autoState;
    @XmlElement(name = "BondedLocation", required = true)
    protected String bondedLocation;
    @XmlElement(name = "CartonCount")
    protected int cartonCount;
    @XmlElement(name = "PackageMarkings", required = true)
    protected String packageMarkings;
    @XmlElement(name = "IEBuisiness", required = true)
    protected String ieBuisiness;
    @XmlElement(name = "IELastName", required = true)
    protected String ieLastName;
    @XmlElement(name = "IEFirstName", required = true)
    protected String ieFirstName;
    @XmlElement(name = "IEMiddleName", required = true)
    protected String ieMiddleName;
    @XmlElement(name = "IEAddress", required = true)
    protected String ieAddress;
    @XmlElement(name = "IECity", required = true)
    protected String ieCity;
    @XmlElement(name = "IEState", required = true)
    protected String ieState;
    @XmlElement(name = "IEZip", required = true)
    protected String ieZip;
    @XmlElement(name = "IEZipPlus4", required = true)
    protected String ieZipPlus4;
    @XmlElement(name = "IEPhone", required = true)
    protected String iePhone;
    @XmlElement(name = "ForBuisiness", required = true)
    protected String forBuisiness;
    @XmlElement(name = "ForLastName", required = true)
    protected String forLastName;
    @XmlElement(name = "ForFirstName", required = true)
    protected String forFirstName;
    @XmlElement(name = "ForMiddleName", required = true)
    protected String forMiddleName;
    @XmlElement(name = "ForAddress", required = true)
    protected String forAddress;
    @XmlElement(name = "ForCity", required = true)
    protected String forCity;
    @XmlElement(name = "ForCountry", required = true)
    protected String forCountry;
    @XmlElement(name = "ForPhone", required = true)
    protected String forPhone;
    @XmlElement(name = "CustomsBroker", required = true)
    protected String customsBroker;
    @XmlElement(name = "CustomsBrokerPhone", required = true)
    protected String customsBrokerPhone;
    @XmlElement(name = "CustomsBrokerFax", required = true)
    protected String customsBrokerFax;
    @XmlElement(name = "CustomsBrokerLastName", required = true)
    protected String customsBrokerLastName;
    @XmlElement(name = "CustomsBrokerFirstName", required = true)
    protected String customsBrokerFirstName;

    public Core() { 
    	this("","","","");
    }
    
    /** Create a core record from information typically available in loan data.
     * 
     * @param importExport
     * @param carrier
     * @param carriersTrackingNumber
     * @param transportationCode
     */
    public Core(String importExport, String carrier, String carriersTrackingNumber, String transportationCode) {
    	setBlanks();
    	setImportExport(importExport);
    	setPurpose("S");
    	setCarrier(carrier);
    	setMasterWaybill(carriersTrackingNumber);
    	setTransportationCode(transportationCode);
    	setCartonCount(0);
    }    
    
    /**
     * Construct a core instance from an eDecLine
     * @param string
     */
    public Core(String eDecCoreLine) {
    	setBlanks();  
		String[] values = eDecCoreLine.split("\\~");
		if (values.length<=38) {
			try { 
			// Valid 
			setImportExport(values[0].replace("\n", ""));
			setPort(values[1].replace("\n", ""));
			setIEDate(values[2].replace("\n", ""));
			setIELicense(values[3].replace("\n", ""));
			setPurpose(values[4].replace("\n", ""));
			setCustomsID(values[5].replace("\n", ""));
			setCarrier(values[6].replace("\n", ""));
			setMasterWaybill(values[7].replace("\n", ""));
			setHouseWaybill(values[8].replace("\n", ""));
			setTransportationCode(values[9].replace("\n", ""));
			
			setAutoLicense(values[10].replace("\n", ""));
			setAutoState(values[11].replace("\n", ""));
			setBondedLocation(values[12].replace("\n", ""));
			setCartonCount(values[13].replace("\n", ""));
			setPackageMarkings(values[14].replace("\n", ""));
			setIEBuisiness(values[15].replace("\n", ""));
			setIELastName(values[16].replace("\n", ""));
			setIEFirstName(values[17].replace("\n", ""));
			setIEMiddleName(values[18].replace("\n", ""));
			setIEAddress(values[19].replace("\n", ""));
			
			setIECity(values[20].replace("\n", ""));
			setIEState(values[21].replace("\n", ""));
			setIEZip(values[22].replace("\n", ""));
			setIEZipPlus4(values[23].replace("\n", ""));
			setIEPhone(values[24].replace("\n", ""));
			setForBuisiness(values[25].replace("\n", ""));
			setForLastName(values[26].replace("\n", ""));
			setForFirstName(values[27].replace("\n", ""));
			setForMiddleName(values[28].replace("\n", ""));
			setForAddress(values[29].replace("\n", ""));
			
			setForCity(values[30].replace("\n", ""));
			setForCountry(values[31].replace("\n", ""));
			setForPhone(values[32].replace("\n", ""));
			setCustomsBroker(values[33].replace("\n", ""));
			setCustomsBrokerPhone(values[34].replace("\n", ""));
			setCustomsBrokerFax(values[35].replace("\n", ""));
			setCustomsBrokerLastName(values[36].replace("\n", ""));
			setCustomsBrokerFirstName(values[37].replace("\n", ""));
			} catch (IndexOutOfBoundsException e) { 
				// Expected if we can't parse a line at the point it becomes 
				// only separators
			}
		} else { 
			System.out.println ("Invalid ("+ values.length +"): [" + eDecCoreLine + "]" );
			// Invalid eDec, must have exactly 38 elements in the core line.
		}
	}

    private void setBlanks() { 
		setImportExport("");
		setPort("");
		setIEDate("");
		setIELicense("");
		setPurpose("S");
		setCustomsID("");
		setCarrier("");
		setMasterWaybill("");
		setHouseWaybill("");
		setTransportationCode("");
		
		setAutoLicense("");
		setAutoState("");
		setBondedLocation("");
		setCartonCount(0);
		setPackageMarkings("");
		
		setIEBuisiness("");
		setIELastName("");
		setIEFirstName("");
		setIEMiddleName("");
		setIEAddress("");
		setIECity("");
		setIEState("");
		setIEZip("");
		setIEZipPlus4("");
		setIEPhone("");
		
		setForBuisiness("");
		setForLastName("");
		setForFirstName("");
		setForMiddleName("");
		setForAddress("");
		setForCity("");
		setForCountry("");
		setForPhone("");
		
		setCustomsBroker("");
		setCustomsBrokerPhone("");
		setCustomsBrokerFax("");
		setCustomsBrokerLastName("");
		setCustomsBrokerFirstName("");
    }
    
	/**
     * Gets the value of the importExport property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getImportExport() {
        return importExport;
    }

    /**
     * Sets the value of the importExport property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setImportExport(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IMPORTEXPORT_SIZE) { value = value.substring(0, Core.IMPORTEXPORT_SIZE); }
        this.importExport = value;
    }

    /**
     * Gets the value of the port property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPort() {
        return port;
    }

    /**
     * Sets the value of the port property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPort(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.PORT_SIZE) { value = value.substring(0, Core.PORT_SIZE); }
        this.port = value;
    }

    /**
     * Gets the value of the ieDate property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getIEDate() {
        return ieDate;
    }

    /**
     * Sets the value of the ieDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setIEDate(XMLGregorianCalendar value) {
        this.ieDate = value;
    }
    
    public void setIEDateFromString(String value) { 
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEDATE_SIZE) { value = value.substring(0, Core.IEDATE_SIZE); }
    	Date date;
		try {
			date = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH).parse(value);
    	    GregorianCalendar gdate = new GregorianCalendar();
    	    gdate.setTime(date);
    	    this.ieDate = DatatypeFactory.newInstance().newXMLGregorianCalendar(gdate);
		} catch (ParseException e) {
			// expected for blank date data
		} catch (DatatypeConfigurationException e) {
			// Not expected.
			e.printStackTrace();
		}
    }
    
    public String getIEDateString() {
    	String result = "";
    	try { 
    	    result = String.format("%d/%d/%4d", ieDate.getMonth(), ieDate.getDay(), ieDate.getYear());
    	} catch (NullPointerException e) {
    		// expected if ieDate is null
    	} 
        return result;
    }    
    
    public void setIEDate(String date) { 
    	DateFormat dateFormat = new SimpleDateFormat("M/d/y");
    	Date parsedDate;
		try {
			parsedDate = dateFormat.parse(date);
			GregorianCalendar newCalendar = (GregorianCalendar) GregorianCalendar.getInstance();
			newCalendar.setTime(parsedDate);
			ieDate = DatatypeFactory.newInstance().newXMLGregorianCalendar(newCalendar);
		} catch (ParseException e) {
			// expected for bad input
		} catch (DatatypeConfigurationException e) {
			// Not expected
			e.printStackTrace();
		}
    }

    /**
     * Gets the value of the ieLicense property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIELicense() {
        return ieLicense;
    }

    /**
     * Sets the value of the ieLicense property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIELicense(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IELICENSE_SIZE) { value = value.substring(0, Core.IELICENSE_SIZE); }
        this.ieLicense = value;
    }

    /**
     * Gets the value of the purpose property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPurpose() {
        return purpose;
    }

    /**
     * Sets the value of the purpose property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPurpose(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.PURPOSE_SIZE) { value = value.substring(0, Core.PURPOSE_SIZE); }
        this.purpose = value;
    }

    /**
     * Gets the value of the customsID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomsID() {
        return customsID;
    }

    /**
     * Sets the value of the customsID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomsID(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CUSTOMSID_SIZE) { value = value.substring(0, Core.CUSTOMSID_SIZE); }
        this.customsID = value;
    }

    /**
     * Gets the value of the carrier property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCarrier() {
        return carrier;
    }

    /**
     * Sets the value of the carrier property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCarrier(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CARRIER_SIZE) { value = value.substring(0, Core.CARRIER_SIZE); }
        this.carrier = value;
    }

    /**
     * Gets the value of the masterWaybill property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMasterWaybill() {
        return masterWaybill;
    }

    /**
     * Sets the value of the masterWaybill property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMasterWaybill(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.MASTERWAYBILL_SIZE) { value = value.substring(0, Core.MASTERWAYBILL_SIZE); }    	
        this.masterWaybill = value;
    }

    /**
     * Gets the value of the houseWaybill property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getHouseWaybill() {
        return houseWaybill;
    }

    /**
     * Sets the value of the houseWaybill property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setHouseWaybill(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.HOUSEWAYBILL_SIZE) { value = value.substring(0, Core.HOUSEWAYBILL_SIZE); }
        this.houseWaybill = value;
    }

    /**
     * Gets the value of the transportationCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransportationCode() {
        return transportationCode;
    }

    /**
     * Sets the value of the transportationCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransportationCode(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.TRANSPORTATIONCODE_SIZE) { value = value.substring(0, Core.TRANSPORTATIONCODE_SIZE); }
        this.transportationCode = value;
    }

    /**
     * Gets the value of the autoLicense property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAutoLicense() {
        return autoLicense;
    }

    /**
     * Sets the value of the autoLicense property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAutoLicense(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.AUTOLICENSE_SIZE) { value = value.substring(0, Core.AUTOLICENSE_SIZE); }
        this.autoLicense = value;
    }

    /**
     * Gets the value of the autoState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAutoState() {
        return autoState;
    }

    /**
     * Sets the value of the autoState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAutoState(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.AUTOSTATE_SIZE) { value = value.substring(0, Core.AUTOSTATE_SIZE); }
        this.autoState = value;
    }

    /**
     * Gets the value of the bondedLocation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBondedLocation() {
        return bondedLocation;
    }

    /**
     * Sets the value of the bondedLocation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBondedLocation(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.BONDEDLOCATION_SIZE) { value = value.substring(0, Core.BONDEDLOCATION_SIZE); }
        this.bondedLocation = value;
    }

    /**
     * Gets the value of the cartonCount property.
     * 
     */
    public int getCartonCount() {
        return cartonCount;
    }

    /**
     * Sets the value of the cartonCount property.
     * 
     */
    public void setCartonCount(int value) {
        this.cartonCount = value;
    }

    public void setCartonCount(String value) {
    	try {
           setCartonCount(Integer.parseInt(value));
    	} catch (NumberFormatException e) { 
    	   cartonCount = 0;
    	}
    }
    
    /**
     * Gets the value of the packageMarkings property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPackageMarkings() {
        return packageMarkings;
    }

    /**
     * Sets the value of the packageMarkings property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPackageMarkings(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.PACKAGEMARKINGS_SIZE) { value = value.substring(0, Core.PACKAGEMARKINGS_SIZE); }
        this.packageMarkings = value;
    }

    /**
     * Gets the value of the ieBuisiness property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEBuisiness() {
        return ieBuisiness;
    }

    /**
     * Sets the value of the ieBuisiness property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEBuisiness(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEBUISINESS_SIZE) { value = value.substring(0, Core.IEBUISINESS_SIZE); }
        this.ieBuisiness = value;
    }

    /**
     * Gets the value of the ieLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIELastName() {
        return ieLastName;
    }

    /**
     * Sets the value of the ieLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIELastName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IELASTNAME_SIZE) { value = value.substring(0, Core.IELASTNAME_SIZE); }
        this.ieLastName = value;
    }

    /**
     * Gets the value of the ieFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEFirstName() {
        return ieFirstName;
    }

    /**
     * Sets the value of the ieFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEFirstName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEFIRSTNAME_SIZE) { value = value.substring(0, Core.IEFIRSTNAME_SIZE); }
        this.ieFirstName = value;
    }

    /**
     * Gets the value of the ieMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEMiddleName() {
        return ieMiddleName;
    }

    /**
     * Sets the value of the ieMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEMiddleName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEMIDDLENAME_SIZE) { value = value.substring(0, Core.IEMIDDLENAME_SIZE); }
        this.ieMiddleName = value;
    }

    /**
     * Gets the value of the ieAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEAddress() {
        return ieAddress;
    }

    /**
     * Sets the value of the ieAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEAddress(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEADDRESS_SIZE) { value = value.substring(0, Core.IEADDRESS_SIZE); }
        this.ieAddress = value;
    }

    /**
     * Gets the value of the ieCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIECity() {
        return ieCity;
    }

    /**
     * Sets the value of the ieCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIECity(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IECITY_SIZE) { value = value.substring(0, Core.IECITY_SIZE); }
        this.ieCity = value;
    }

    /**
     * Gets the value of the ieState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEState() {
        return ieState;
    }

    /**
     * Sets the value of the ieState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEState(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IESTATE_SIZE) { value = value.substring(0, Core.IESTATE_SIZE); }
        this.ieState = value;
    }

    /**
     * Gets the value of the ieZip property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEZip() {
        return ieZip;
    }

    /**
     * Sets the value of the ieZip property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEZip(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEZIP_SIZE) { value = value.substring(0, Core.IEZIP_SIZE); }
        this.ieZip = value;
    }

    /**
     * Gets the value of the ieZipPlus4 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEZipPlus4() {
        return ieZipPlus4;
    }

    /**
     * Sets the value of the ieZipPlus4 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEZipPlus4(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEZIPPLUS4_SIZE) { 
    	    value = value.substring(0, Core.IEZIPPLUS4_SIZE);
    	}
        this.ieZipPlus4 = value;
    }

    /**
     * Gets the value of the iePhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIEPhone() {
        return iePhone;
    }

    /**
     * Sets the value of the iePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIEPhone(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.IEPHONE_SIZE) { value = value.substring(0, Core.IEPHONE_SIZE); }
        this.iePhone = value;
    }

    /**
     * Gets the value of the forBuisiness property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForBuisiness() {
        return forBuisiness;
    }

    /**
     * Sets the value of the forBuisiness property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForBuisiness(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORBUISINESS_SIZE) { value = value.substring(0, Core.FORBUISINESS_SIZE); }
        this.forBuisiness = value;
    }

    /**
     * Gets the value of the forLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForLastName() {
        return forLastName;
    }

    /**
     * Sets the value of the forLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForLastName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORLASTNAME_SIZE) { value = value.substring(0, Core.FORLASTNAME_SIZE); }
        this.forLastName = value;
    }

    /**
     * Gets the value of the forFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForFirstName() {
        return forFirstName;
    }

    /**
     * Sets the value of the forFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForFirstName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORFIRSTNAME_SIZE) { value = value.substring(0, Core.FORFIRSTNAME_SIZE); }
        this.forFirstName = value;
    }

    /**
     * Gets the value of the forMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForMiddleName() {
        return forMiddleName;
    }

    /**
     * Sets the value of the forMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForMiddleName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORMIDDLENAME_SIZE) { value = value.substring(0, Core.FORMIDDLENAME_SIZE); }
        this.forMiddleName = value;
    }

    /**
     * Gets the value of the forAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForAddress() {
        return forAddress;
    }

    /**
     * Sets the value of the forAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForAddress(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORADDRESS_SIZE) { value = value.substring(0, Core.FORADDRESS_SIZE); }
        this.forAddress = value;
    }

    /**
     * Gets the value of the forCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForCity() {
        return forCity;
    }

    /**
     * Sets the value of the forCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForCity(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORCITY_SIZE) { value = value.substring(0, Core.FORCITY_SIZE); }
        this.forCity = value;
    }

    /**
     * Gets the value of the forCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForCountry() {
        return forCountry;
    }

    /**
     * Sets the value of the forCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForCountry(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORCOUNTRY_SIZE) { value = value.substring(0, Core.FORCOUNTRY_SIZE); }
        this.forCountry = value;
    }

    /**
     * Gets the value of the forPhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForPhone() {
        return forPhone;
    }

    /**
     * Sets the value of the forPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForPhone(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.FORPHONE_SIZE) { value = value.substring(0, Core.FORPHONE_SIZE); }
        this.forPhone = value;
    }

    /**
     * Gets the value of the customsBroker property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomsBroker() {
        return customsBroker;
    }

    /**
     * Sets the value of the customsBroker property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomsBroker(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CUSTOMSBROKER_SIZE) { value = value.substring(0, Core.CUSTOMSBROKER_SIZE); }
        this.customsBroker = value;
    }

    /**
     * Gets the value of the customsBrokerPhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomsBrokerPhone() {
        return customsBrokerPhone;
    }

    /**
     * Sets the value of the customsBrokerPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomsBrokerPhone(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CUSTOMSBROKERPHONE_SIZE) { value = value.substring(0, Core.CUSTOMSBROKERPHONE_SIZE); }
        this.customsBrokerPhone = value;
    }

    /**
     * Gets the value of the customsBrokerFax property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomsBrokerFax() {
        return customsBrokerFax;
    }

    /**
     * Sets the value of the customsBrokerFax property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomsBrokerFax(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CUSTOMSBROKERFAX_SIZE) { value = value.substring(0, Core.CUSTOMSBROKERFAX_SIZE); }
        this.customsBrokerFax = value;
    }

    /**
     * Gets the value of the customsBrokerLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomsBrokerLastName() {
        return customsBrokerLastName;
    }

    /**
     * Sets the value of the customsBrokerLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomsBrokerLastName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CUSTOMSBROKERLASTNAME_SIZE) { value = value.substring(0, Core.CUSTOMSBROKERLASTNAME_SIZE); }
        this.customsBrokerLastName = value;
    }

    /**
     * Gets the value of the customsBrokerFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomsBrokerFirstName() {
        return customsBrokerFirstName;
    }

    /**
     * Sets the value of the customsBrokerFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomsBrokerFirstName(String value) {
    	if (value==null) { 
    		value = "";
    	}
    	if (value.length()>Core.CUSTOMSBROKERFIRSTNAME_SIZE) { value = value.substring(0, Core.CUSTOMSBROKERFIRSTNAME_SIZE); }
        this.customsBrokerFirstName = value;
    }

    /** Serialize the core record as a line in an eDec file, not including
     * the trailing pipe character at the end of the line.
     * 
     * @return
     */
	public String toEDecLine() {
		StringBuffer result = new StringBuffer();
		result.append(getImportExport()).append("~");
		result.append(getPort()).append("~");
		result.append(getIEDateString()).append("~");
		result.append(getIELicense()).append("~");
		result.append(getPurpose()).append("~");
		result.append(getCustomsID()).append("~");
		result.append(getCarrier()).append("~");
		result.append(getMasterWaybill()).append("~");
		result.append(getHouseWaybill()).append("~");
		result.append(getTransportationCode()).append("~");
			
		result.append(getAutoLicense()).append("~");
		result.append(getAutoState()).append("~");
		result.append(getBondedLocation()).append("~");
		result.append(getCartonCount()).append("~");
		result.append(getPackageMarkings()).append("~");
		result.append(getIEBuisiness()).append("~");
		result.append(getIELastName()).append("~");
		result.append(getIEFirstName()).append("~");
		result.append(getIEMiddleName()).append("~");
		result.append(getIEAddress()).append("~");
			
		result.append(getIECity()).append("~");
		result.append(getIEState()).append("~");
		result.append(getIEZip()).append("~");
		result.append(getIEZipPlus4()).append("~");
		result.append(getIEPhone()).append("~");
		result.append(getForBuisiness()).append("~");
		result.append(getForLastName()).append("~");
		result.append(getForFirstName()).append("~");
		result.append(getForMiddleName()).append("~");
		result.append(getForAddress()).append("~");
			
		result.append(getForCity()).append("~");
		result.append(getForCountry()).append("~");
		result.append(getForPhone()).append("~");
		result.append(getCustomsBroker()).append("~");
		result.append(getCustomsBrokerPhone()).append("~");
		result.append(getCustomsBrokerFax()).append("~");
		result.append(getCustomsBrokerLastName()).append("~");
		result.append(getCustomsBrokerFirstName());
		
		return result.toString();
	}

	
	
}
