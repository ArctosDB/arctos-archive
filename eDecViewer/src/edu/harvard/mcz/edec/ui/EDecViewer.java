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
package edu.harvard.mcz.edec.ui;

import java.awt.EventQueue;
import java.awt.Point;

import javax.swing.ComboBoxModel;
import javax.swing.DefaultCellEditor;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.regex.Pattern;

import com.jgoodies.forms.layout.FormLayout;
import com.jgoodies.forms.layout.ColumnSpec;
import com.jgoodies.forms.layout.RowSpec;
import com.jgoodies.forms.factories.FormFactory;

import edu.harvard.mcz.edec.Core;
import edu.harvard.mcz.edec.Country;
import edu.harvard.mcz.edec.Country.CountryAndCode;
import edu.harvard.mcz.edec.EDec;
import edu.harvard.mcz.edec.Species;

import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JFormattedTextField;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableColumn;
import javax.swing.text.DefaultFormatter;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JComboBox;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JPopupMenu;
import java.awt.Component;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

/**
 * User Interface for editing edec files.
 * 
 * @author mole
 *
 */
public class EDecViewer {
	
	private EDec edec;

	private JFrame frame;
	private JComboBox textFieldImportExport;
	private JTextField textFieldFilename;
	private JTextField textFieldPort;
	private JTextField textFieldCarrier;
	private JTable table;
	private JTextField textFieldIEDate;
	private JTextField textFieldMasterWaybill;
	private JTextField textFieldHouseWaybill;
	private JTextField textFieldPurpose;
	private JTextField textFieldCustomsNumber;
	private JTextField textFieldTransportationCode;
	private JTextField textFieldAutoLicence;
	private JTextField textFieldAutoState;
	private JTextField textFieldIEBuisness;
	private JTextField textFieldIELast;
	private JTextField textFieldIEFirst;
	private JTextField textFieldIEMiddle;
	private JTextField textFieldIEAddress;
	private JTextField textFieldIECity;
	private JTextField textFieldIEState;
	private JTextField textFieldIEZip;
	private JTextField textFieldIEPhone;
	private JTextField textFieldZipPlus4;
	private JTextField textFieldBrokerName;
	private JTextField textFieldBrokerFax;
	private JTextField textFieldBrokerContactLastName;
	private JTextField textFieldBrokerContactFirstName;
	private JTextField textFieldBrokerPhone;
	private JTextField textFieldBondedLocation;
	private JTextField textFieldNumberOfCartons;
	private JTextField textFieldPackageMarkings;
	private JTextField textFieldForBuisness;
	private JTextField textFieldForLastName;
	private JTextField textFieldForFirstName;
	private JTextField textFieldForMiddleName;
	private JTextField textFieldForAddress;
	private JTextField textFieldForCity;
	private JComboBox<CountryAndCode> comboBoxForCountry;
	private JTextField textFieldForPhone;
	
	private Point popupPoint;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					EDecViewer window = new EDecViewer();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public EDecViewer() {
		initialize();
		loadData(new EDec());
	}

	/**
	 * Initialize the contents of the frame.
	 * @param CountryAndCode 
	 */
	@SuppressWarnings("unchecked")
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 790, 777);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JMenuBar menuBar = new JMenuBar();
		frame.setJMenuBar(menuBar);
		
		JMenu mnFile = new JMenu("File");
		mnFile.setMnemonic(KeyEvent.VK_F);
		menuBar.add(mnFile);
		
		JMenuItem mntmLoad = new JMenuItem("Open");
		mntmLoad.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
                loadFromFile();
			}
		});
		mntmLoad.setMnemonic(KeyEvent.VK_O);
		mnFile.add(mntmLoad);
		
		JMenuItem mntmSave = new JMenuItem("Save");
		mntmSave.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				textFieldPort.grabFocus();
				textFieldCarrier.grabFocus();
				storeValues();
				System.out.println(edec.toEDecDocument());
				saveToFile();
			}
		});
		mntmSave.setMnemonic(KeyEvent.VK_S);
		mnFile.add(mntmSave);
		
		JMenuItem mntmExit = new JMenuItem("Exit");
		mntmExit.setMnemonic(KeyEvent.VK_X);
		mntmExit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		mnFile.add(mntmExit);
		
		JMenu mnSpecies = new JMenu("Species");
		mnSpecies.setMnemonic(KeyEvent.VK_S);
		menuBar.add(mnSpecies);
		
		JMenuItem mntmAddSpecies = new JMenuItem("Add Species");
		mntmAddSpecies.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				((SpeciesTableModel)table.getModel()).addRow();
			}
		});
		mntmAddSpecies.setMnemonic(KeyEvent.VK_A);
		mnSpecies.add(mntmAddSpecies);
		
		JMenuItem mntmSpeciesToCSV = new JMenuItem("Save Species List to csv");
		mntmSpeciesToCSV.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				saveSpeciesToCSVFile();
			}
		});
		mnSpecies.add(mntmSpeciesToCSV);

		JMenuItem mntmSpeciesFromCSV = new JMenuItem("Add Species from csv");
		mntmSpeciesFromCSV.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				loadSpeciesFromCSVFile(false);
			}
		});
		mnSpecies.add(mntmSpeciesFromCSV);
		
		JMenuItem mntmSpeciesFromCSVr = new JMenuItem("Replace Species List from csv");
		mntmSpeciesFromCSVr.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				loadSpeciesFromCSVFile(true);
			}
		});
		mnSpecies.add(mntmSpeciesFromCSVr);		
		
		frame.getContentPane().setLayout(new FormLayout(new ColumnSpec[] {
				FormFactory.RELATED_GAP_COLSPEC,
				ColumnSpec.decode("right:default"),
				FormFactory.RELATED_GAP_COLSPEC,
				ColumnSpec.decode("center:max(75dlu;default):grow"),
				FormFactory.RELATED_GAP_COLSPEC,
				FormFactory.DEFAULT_COLSPEC,
				FormFactory.RELATED_GAP_COLSPEC,
				ColumnSpec.decode("right:default"),
				FormFactory.RELATED_GAP_COLSPEC,
				ColumnSpec.decode("max(78dlu;default):grow"),
				FormFactory.RELATED_GAP_COLSPEC,
				ColumnSpec.decode("default:grow"),},
			new RowSpec[] {
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				FormFactory.DEFAULT_ROWSPEC,
				FormFactory.RELATED_GAP_ROWSPEC,
				RowSpec.decode("default:grow"),}));
		
		JLabel lblFile = new JLabel("File");
		frame.getContentPane().add(lblFile, "2, 2, right, default");
		
		textFieldFilename = new JTextField();
		textFieldFilename.setEditable(false);
		frame.getContentPane().add(textFieldFilename, "4, 2, 3, 1, fill, default");
		textFieldFilename.setColumns(10);
		
	    Pattern patternIE = Pattern.compile("^[IE]$");
	    RegexPatternFormatter patternIEFormatter = new RegexPatternFormatter(patternIE);
		
		JLabel lblNewLabel_1 = new JLabel("Import/Export Date");
		frame.getContentPane().add(lblNewLabel_1, "2, 4, right, default");
		
		textFieldIEDate = new JTextField();
		frame.getContentPane().add(textFieldIEDate, "4, 4, 3, 1, fill, default");
		textFieldIEDate.setColumns(Core.IEDATE_SIZE);
		
		JLabel lblCarrier = new JLabel("Carrier");
		frame.getContentPane().add(lblCarrier, "8, 4, right, default");
		
		textFieldCarrier = new JTextField();
		frame.getContentPane().add(textFieldCarrier, "10, 4, 3, 1, fill, default");
		textFieldCarrier.setColumns(10);
		
		JLabel lblNewLabel_3 = new JLabel("I/E License Number");
		frame.getContentPane().add(lblNewLabel_3, "2, 6");
		
		JLabel lblNewLabel_2 = new JLabel("Air Waybill or Bill of Lading No.");
		frame.getContentPane().add(lblNewLabel_2, "8, 6, 5, 1");
		
		JLabel lblImportexport = new JLabel("Import/Export");
		frame.getContentPane().add(lblImportexport, "2, 8, right, default");
		textFieldImportExport = new JComboBox();
		textFieldImportExport.setModel(new DefaultComboBoxModel(new String[] {"","I", "E"}));
		textFieldImportExport.setToolTipText("I for Import, E for Export");
		frame.getContentPane().add(textFieldImportExport, "4, 8, 3, 1, fill, default");
		
		JLabel lblMaster = new JLabel("Master");
		frame.getContentPane().add(lblMaster, "8, 8, right, default");
		
		textFieldMasterWaybill = new JTextField();
		frame.getContentPane().add(textFieldMasterWaybill, "10, 8, 3, 1, fill, default");
		textFieldMasterWaybill.setColumns(10);
		
		JLabel lblNewLabel = new JLabel("Port of Clearance");
		frame.getContentPane().add(lblNewLabel, "2, 10, right, default");
		
		textFieldPort = new JTextField();
		textFieldPort.setColumns(Core.PORT_SIZE);
		frame.getContentPane().add(textFieldPort, "4, 10, 3, 1, fill, default");
		textFieldPort.setColumns(10);
		
		JLabel lblHouse = new JLabel("House");
		frame.getContentPane().add(lblHouse, "8, 10, right, default");
		
		textFieldHouseWaybill = new JTextField();
		frame.getContentPane().add(textFieldHouseWaybill, "10, 10, 3, 1, fill, default");
		textFieldHouseWaybill.setColumns(10);
		
		JLabel lblPurpose = new JLabel("Purpose");
		frame.getContentPane().add(lblPurpose, "2, 12, right, default");
		
		textFieldPurpose = new JTextField();
		textFieldPurpose.setText("");
		frame.getContentPane().add(textFieldPurpose, "4, 12, 3, 1, fill, default");
		textFieldPurpose.setColumns(10);
		
		JLabel lblTransportationCode = new JLabel("Transportation Code");
		frame.getContentPane().add(lblTransportationCode, "8, 12, right, default");
		
		textFieldTransportationCode = new JTextField();
		frame.getContentPane().add(textFieldTransportationCode, "10, 12, 3, 1, fill, default");
		textFieldTransportationCode.setColumns(10);
		
		JLabel lblNewLabel_4 = new JLabel("Customs Entry Number");
		frame.getContentPane().add(lblNewLabel_4, "2, 14, right, default");
		
		textFieldCustomsNumber = new JTextField();
		textFieldCustomsNumber.setText("");
		frame.getContentPane().add(textFieldCustomsNumber, "4, 14, 3, 1, fill, default");
		textFieldCustomsNumber.setColumns(10);
		
		JLabel lblAutoLicenceNo = new JLabel("Auto Licence No.");
		frame.getContentPane().add(lblAutoLicenceNo, "8, 14, right, default");
		
		textFieldAutoLicence = new JTextField();
		frame.getContentPane().add(textFieldAutoLicence, "10, 14, 3, 1, fill, default");
		textFieldAutoLicence.setColumns(10);
		
		JLabel lblState = new JLabel("State");
		frame.getContentPane().add(lblState, "8, 16, right, default");
		
		textFieldAutoState = new JTextField();
		textFieldAutoState.setText("");
		frame.getContentPane().add(textFieldAutoState, "10, 16, 3, 1, fill, default");
		textFieldAutoState.setColumns(10);
		
		JLabel lblBondedLocation = new JLabel("Bonded Location");
		frame.getContentPane().add(lblBondedLocation, "8, 18, right, default");
		
		textFieldBondedLocation = new JTextField();
		frame.getContentPane().add(textFieldBondedLocation, "10, 18, 3, 1, fill, default");
		textFieldBondedLocation.setColumns(10);
		
		JLabel lblNumberOfCartons = new JLabel("Number of Cartons");
		frame.getContentPane().add(lblNumberOfCartons, "8, 20, right, default");
		
		textFieldNumberOfCartons = new JTextField();
		frame.getContentPane().add(textFieldNumberOfCartons, "10, 20, 3, 1, fill, default");
		textFieldNumberOfCartons.setColumns(10);
		
		JLabel lblNewLabel_8 = new JLabel("US Importer/Exporter");
		frame.getContentPane().add(lblNewLabel_8, "2, 22, 5, 1");
		
		JLabel lblPackageMarkings = new JLabel("Package Markings");
		frame.getContentPane().add(lblPackageMarkings, "8, 22, right, default");
		
		textFieldPackageMarkings = new JTextField();
		frame.getContentPane().add(textFieldPackageMarkings, "10, 22, 3, 1, fill, default");
		textFieldPackageMarkings.setColumns(10);
		
		JLabel lblNewLabel_17 = new JLabel("Buisness Name");
		frame.getContentPane().add(lblNewLabel_17, "2, 24, right, default");
		
		textFieldIEBuisness = new JTextField();
		frame.getContentPane().add(textFieldIEBuisness, "4, 24, 3, 1, fill, default");
		textFieldIEBuisness.setColumns(10);
		
		JLabel lblForeignSupplierreciever = new JLabel("Foreign Supplier/Reciever");
		frame.getContentPane().add(lblForeignSupplierreciever, "8, 24, 5, 1");
		
		JLabel lblNewLabel_9 = new JLabel("Last Name");
		frame.getContentPane().add(lblNewLabel_9, "2, 26, right, default");
		
		textFieldIELast = new JTextField();
		textFieldIELast.setText("");
		frame.getContentPane().add(textFieldIELast, "4, 26, 3, 1, fill, default");
		textFieldIELast.setColumns(10);
		
		JLabel lblNewLabel_5 = new JLabel("Buisness Name");
		frame.getContentPane().add(lblNewLabel_5, "8, 26, right, default");
		
		textFieldForBuisness = new JTextField();
		frame.getContentPane().add(textFieldForBuisness, "10, 26, 3, 1, fill, default");
		textFieldForBuisness.setColumns(10);
		
		JLabel lblNewLabel_10 = new JLabel("First Name");
		frame.getContentPane().add(lblNewLabel_10, "2, 28, right, default");
		
		textFieldIEFirst = new JTextField();
		frame.getContentPane().add(textFieldIEFirst, "4, 28, 3, 1, fill, default");
		textFieldIEFirst.setColumns(10);
		
		JLabel lblNewLabel_6 = new JLabel("Last Name");
		frame.getContentPane().add(lblNewLabel_6, "8, 28, right, default");
		
		textFieldForLastName = new JTextField();
		frame.getContentPane().add(textFieldForLastName, "10, 28, 3, 1, fill, default");
		textFieldForLastName.setColumns(10);
		
		JLabel lblNewLabel_11 = new JLabel("Middle Name");
		frame.getContentPane().add(lblNewLabel_11, "2, 30, right, default");
		
		textFieldIEMiddle = new JTextField();
		frame.getContentPane().add(textFieldIEMiddle, "4, 30, 3, 1, fill, default");
		textFieldIEMiddle.setColumns(10);
		
		JLabel lblNewLabel_7 = new JLabel("First Name");
		frame.getContentPane().add(lblNewLabel_7, "8, 30, right, default");
		
		textFieldForFirstName = new JTextField();
		frame.getContentPane().add(textFieldForFirstName, "10, 30, 3, 1, fill, default");
		textFieldForFirstName.setColumns(10);
		
		JLabel lblNewLabel_12 = new JLabel("Buisness Address");
		frame.getContentPane().add(lblNewLabel_12, "2, 32, right, default");
		
		textFieldIEAddress = new JTextField();
		frame.getContentPane().add(textFieldIEAddress, "4, 32, 3, 1, fill, default");
		textFieldIEAddress.setColumns(10);
		
		JLabel lblMiddleName = new JLabel("Middle Name");
		frame.getContentPane().add(lblMiddleName, "8, 32, right, default");
		
		textFieldForMiddleName = new JTextField();
		frame.getContentPane().add(textFieldForMiddleName, "10, 32, 3, 1, fill, default");
		textFieldForMiddleName.setColumns(10);
		
		JLabel lblNewLabel_13 = new JLabel("City");
		frame.getContentPane().add(lblNewLabel_13, "2, 34, right, default");
		
		textFieldIECity = new JTextField();
		frame.getContentPane().add(textFieldIECity, "4, 34, 3, 1, fill, default");
		textFieldIECity.setColumns(10);
		
		JLabel lblAddress = new JLabel("Address");
		frame.getContentPane().add(lblAddress, "8, 34, right, default");
		
		textFieldForAddress = new JTextField();
		frame.getContentPane().add(textFieldForAddress, "10, 34, 3, 1, fill, default");
		textFieldForAddress.setColumns(10);
		
		JLabel lblNewLabel_14 = new JLabel("State");
		frame.getContentPane().add(lblNewLabel_14, "2, 36, right, default");
		
		textFieldIEState = new JTextField();
		frame.getContentPane().add(textFieldIEState, "4, 36, 3, 1, fill, default");
		textFieldIEState.setColumns(10);
		
		JLabel lblCity = new JLabel("City");
		frame.getContentPane().add(lblCity, "8, 36, right, default");
		
		textFieldForCity = new JTextField();
		frame.getContentPane().add(textFieldForCity, "10, 36, 3, 1, fill, default");
		textFieldForCity.setColumns(10);
		
		JLabel lblNewLabel_15 = new JLabel("Zip");
		frame.getContentPane().add(lblNewLabel_15, "2, 38, right, default");
		
		textFieldIEZip = new JTextField();
		frame.getContentPane().add(textFieldIEZip, "4, 38, fill, default");
		textFieldIEZip.setColumns(10);
		
		textFieldZipPlus4 = new JTextField();
		frame.getContentPane().add(textFieldZipPlus4, "6, 38, fill, default");
		textFieldZipPlus4.setColumns(4);
		
		JLabel lblCountry = new JLabel("Country");
		frame.getContentPane().add(lblCountry, "8, 38, right, default");
		
		//textFieldForCountry = new JComboBox<String>(Locale.getISOCountries());
		DefaultComboBoxModel<CountryAndCode> model = new DefaultComboBoxModel<CountryAndCode>(new Country().getCountryArray());
		comboBoxForCountry = new JComboBox<CountryAndCode>(model);
		frame.getContentPane().add(comboBoxForCountry, "10, 38, 3, 1, fill, default");
		
		JLabel lblNewLabel_16 = new JLabel("Phone number");
		frame.getContentPane().add(lblNewLabel_16, "2, 40, right, default");
		
		textFieldIEPhone = new JTextField();
		frame.getContentPane().add(textFieldIEPhone, "4, 40, 3, 1, fill, default");
		textFieldIEPhone.setColumns(10);
		
		JLabel lblPhoneNumer = new JLabel("Phone Number");
		frame.getContentPane().add(lblPhoneNumer, "8, 40, right, default");
		
		textFieldForPhone = new JTextField();
		frame.getContentPane().add(textFieldForPhone, "10, 40, 3, 1, fill, default");
		textFieldForPhone.setColumns(10);
		
		JLabel lblCustomsBroker = new JLabel("Customs Broker");
		frame.getContentPane().add(lblCustomsBroker, "2, 42, 5, 1");
		
		JLabel lblBrokerName = new JLabel("Broker Name");
		frame.getContentPane().add(lblBrokerName, "2, 44, right, default");
		
		textFieldBrokerName = new JTextField();
		frame.getContentPane().add(textFieldBrokerName, "4, 44, 3, 1, fill, default");
		textFieldBrokerName.setColumns(10);
		
		JLabel lblNewLabel_18 = new JLabel("Broker Phone");
		frame.getContentPane().add(lblNewLabel_18, "8, 44, right, default");
		
		textFieldBrokerPhone = new JTextField();
		frame.getContentPane().add(textFieldBrokerPhone, "10, 44, 3, 1, fill, default");
		textFieldBrokerPhone.setColumns(10);
		
		JLabel lblBrokerFax = new JLabel("Broker Fax");
		frame.getContentPane().add(lblBrokerFax, "2, 46, right, default");
		
		textFieldBrokerFax = new JTextField();
		frame.getContentPane().add(textFieldBrokerFax, "4, 46, 3, 1, fill, default");
		textFieldBrokerFax.setColumns(10);
		
		JLabel lblBrokerLastName = new JLabel("Broker Contact Last Name");
		frame.getContentPane().add(lblBrokerLastName, "2, 48, right, default");
		
		textFieldBrokerContactLastName = new JTextField();
		frame.getContentPane().add(textFieldBrokerContactLastName, "4, 48, 3, 1, fill, default");
		textFieldBrokerContactLastName.setColumns(10);
		
		JLabel lblBrokerFirstName = new JLabel("Broker Contact First Name");
		frame.getContentPane().add(lblBrokerFirstName, "8, 48, right, default");
		
		textFieldBrokerContactFirstName = new JTextField();
		frame.getContentPane().add(textFieldBrokerContactFirstName, "10, 48, 3, 1, fill, default");
		textFieldBrokerContactFirstName.setColumns(10);
		
		JScrollPane scrollPane = new JScrollPane();
		frame.getContentPane().add(scrollPane, "2, 50, 11, 1, fill, fill");
		
		table = new JTable();
		
		scrollPane.setViewportView(table);
		
		JPopupMenu popupMenu = new JPopupMenu();
		addPopup(table, popupMenu);
		
		JMenuItem mntmAddRow = new JMenuItem("Add Row");
		mntmAddRow.addActionListener(new ActionListener(){

			@Override
			public void actionPerformed(ActionEvent e) {
				((SpeciesTableModel)table.getModel()).addRow();
			}}); 
		popupMenu.add(mntmAddRow);
		
		JMenuItem mntmDeleteRow = new JMenuItem("Delete Row");
		mntmDeleteRow.addActionListener(new ActionListener(){

			@Override
			public void actionPerformed(ActionEvent e) {
				((SpeciesTableModel)table.getModel()).removeRow(table.rowAtPoint(popupPoint));
			}}); 
		popupMenu.add(mntmDeleteRow);
		
	}

	protected void loadFromFile() {
		EDec edecLoad = null;
		final JFileChooser fileChooser = new JFileChooser();
		fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int returnValue = fileChooser.showOpenDialog(frame);
		if (returnValue == JFileChooser.APPROVE_OPTION) {
			File file = fileChooser.getSelectedFile();
			if (file.canRead() && file.exists()) {
				try {
					BufferedReader stream = new BufferedReader (new FileReader(file));
					StringBuffer edecText = new StringBuffer();
					String line = null;
					while ( (line=stream.readLine()) != null ) { 
						edecText.append(line).append("\n");
					}
					edecLoad = new EDec(edecText.toString());
					textFieldFilename.setText(file.getName());
					if (edecLoad!=null) { 
						loadData(edecLoad);
					}
				} catch (IOException e1) {
					JOptionPane.showMessageDialog(frame,
						    "Problem reading file. " + e1.getMessage(),
						    "Error in reading file.",
						    JOptionPane.WARNING_MESSAGE);
				}
			}
		}
	}

	public class RegexPatternFormatter extends DefaultFormatter {

		  protected java.util.regex.Matcher matcher;

		  public RegexPatternFormatter(java.util.regex.Pattern regex) {
		    setOverwriteMode(false);
		    matcher = regex.matcher(""); // create a Matcher for the regular expression
		  }

		  public Object stringToValue(String string) throws java.text.ParseException {
		    if (string == null) return null;
		    matcher.reset(string); // set 'string' as the matcher's input

		    if (! matcher.matches()) // Does 'string' match the regular expression?
		      throw new java.text.ParseException("does not match regex", 0);

		    // If we get this far, then it did match.
		    return super.stringToValue(string); // will honor the 'valueClass' property
		  }	
	}
	
	public void loadData(EDec eDec) { 
		this.edec = eDec;
		try { 
		   textFieldImportExport.setSelectedItem(edec.getCoreFields().getImportExport());
		} catch (Exception e) { } 
		textFieldPort.setText(edec.getCoreFields().getPort());
		textFieldCarrier.setText(edec.getCoreFields().getCarrier());
		textFieldIEDate.setText(edec.getCoreFields().getIEDateString());
		textFieldMasterWaybill.setText(edec.getCoreFields().getMasterWaybill());
		textFieldHouseWaybill.setText(edec.getCoreFields().getHouseWaybill());
		textFieldPurpose.setText(edec.getCoreFields().getPurpose());
		textFieldCustomsNumber.setText(edec.getCoreFields().getCustomsID());
		textFieldTransportationCode.setText(edec.getCoreFields().getTransportationCode());
		textFieldAutoLicence.setText(edec.getCoreFields().getAutoLicense());
		textFieldAutoState.setText(edec.getCoreFields().getAutoState());
		textFieldIEBuisness.setText(edec.getCoreFields().getIEBuisiness());
		textFieldIELast.setText(edec.getCoreFields().getIELastName());
		textFieldIEFirst.setText(edec.getCoreFields().getIEFirstName());
		textFieldIEMiddle.setText(edec.getCoreFields().getIEMiddleName());
		textFieldIEAddress.setText(edec.getCoreFields().getIEAddress());
		textFieldIECity.setText(edec.getCoreFields().getIECity());
		textFieldIEState.setText(edec.getCoreFields().getIEState());
		textFieldIEZip.setText(edec.getCoreFields().getIEZip());
		textFieldIEPhone.setText(edec.getCoreFields().getIEPhone());
		textFieldZipPlus4.setText(edec.getCoreFields().getIEZipPlus4());
		textFieldBrokerName.setText(edec.getCoreFields().getCustomsBroker());
		textFieldBrokerFax.setText(edec.getCoreFields().getCustomsBrokerFax());
		textFieldBrokerContactLastName.setText(edec.getCoreFields().getCustomsBrokerLastName());
		textFieldBrokerContactFirstName.setText(edec.getCoreFields().getCustomsBrokerFirstName());
		textFieldBrokerPhone.setText(edec.getCoreFields().getCustomsBrokerPhone());
		textFieldBondedLocation.setText(edec.getCoreFields().getBondedLocation());
		textFieldNumberOfCartons.setText(Integer.toString(edec.getCoreFields().getCartonCount()));
		textFieldPackageMarkings.setText(edec.getCoreFields().getPackageMarkings());
		textFieldForBuisness.setText(edec.getCoreFields().getForBuisiness());
		textFieldForLastName.setText(edec.getCoreFields().getForLastName());
		textFieldForFirstName.setText(edec.getCoreFields().getForFirstName());
		textFieldForMiddleName.setText(edec.getCoreFields().getForMiddleName());
		textFieldForAddress.setText(edec.getCoreFields().getForAddress());
		textFieldForCity.setText(edec.getCoreFields().getForCity());
		System.out.println(edec.getCoreFields().getForCountry());
		CountryAndCode country = new Country().getObjectForCode(edec.getCoreFields().getForCountry());
		((DefaultComboBoxModel)comboBoxForCountry.getModel()).addElement(country);
		comboBoxForCountry.setSelectedItem(country);
		textFieldForPhone.setText(edec.getCoreFields().getForPhone());
		
		table.setModel(new SpeciesTableModel(edec.getSpeciesFields()));
		TableColumn columnCountry = table.getColumnModel().getColumn(SpeciesTableModel.COLUMN_COUNTRY_OF_ORIGIN);
		DefaultComboBoxModel<CountryAndCode> model = new DefaultComboBoxModel<CountryAndCode>(new Country().getCountryArray());
		columnCountry.setCellEditor(new DefaultCellEditor(new JComboBox<CountryAndCode>(model)));
		
	}
	
	public void storeValues() {
		if (textFieldImportExport.getSelectedIndex()>-1) { 
			edec.getCoreFields().setImportExport((String)textFieldImportExport.getSelectedItem());
		}
		edec.getCoreFields().setPort(textFieldPort.getText());
		edec.getCoreFields().setCarrier(textFieldCarrier.getText());
		edec.getCoreFields().setIEDateFromString(textFieldIEDate.getText());
		edec.getCoreFields().setMasterWaybill(textFieldMasterWaybill.getText());
		edec.getCoreFields().setHouseWaybill(textFieldHouseWaybill.getText());
		edec.getCoreFields().setPurpose(textFieldPurpose.getText());
		edec.getCoreFields().setCustomsID(textFieldCustomsNumber.getText());
		edec.getCoreFields().setTransportationCode(textFieldTransportationCode.getText());
		edec.getCoreFields().setAutoLicense(textFieldAutoLicence.getText());
		edec.getCoreFields().setAutoState(textFieldAutoState.getText());
		edec.getCoreFields().setIEBuisiness(textFieldIEBuisness.getText());
		edec.getCoreFields().setIELastName(textFieldIELast.getText());
		edec.getCoreFields().setIEFirstName(textFieldIEFirst.getText());
		edec.getCoreFields().setIEMiddleName(textFieldIEMiddle.getText());
		edec.getCoreFields().setIEAddress(textFieldIEAddress.getText());
		edec.getCoreFields().setIECity(textFieldIECity.getText());
		edec.getCoreFields().setIEState(textFieldIEState.getText());
		edec.getCoreFields().setIEZip(textFieldIEZip.getText());
		edec.getCoreFields().setIEPhone(textFieldIEPhone.getText());
		edec.getCoreFields().setIEZipPlus4(textFieldZipPlus4.getText());
		edec.getCoreFields().setCustomsBroker(textFieldBrokerName.getText());
		edec.getCoreFields().setCustomsBrokerFax(textFieldBrokerFax.getText());
		edec.getCoreFields().setCustomsBrokerLastName(textFieldBrokerContactLastName.getText());
		edec.getCoreFields().setCustomsBrokerFirstName(textFieldBrokerContactFirstName.getText());
		edec.getCoreFields().setCustomsBrokerPhone(textFieldBrokerPhone.getText());
		edec.getCoreFields().setBondedLocation(textFieldBondedLocation.getText());
		edec.getCoreFields().setCartonCount(Integer.parseInt(textFieldNumberOfCartons.getText()));
		edec.getCoreFields().setPackageMarkings(textFieldPackageMarkings.getText());
		edec.getCoreFields().setForBuisiness(textFieldForBuisness.getText());
		edec.getCoreFields().setForLastName(textFieldForLastName.getText());
		edec.getCoreFields().setForFirstName(textFieldForFirstName.getText());
		edec.getCoreFields().setForMiddleName(textFieldForMiddleName.getText());
		edec.getCoreFields().setForAddress(textFieldForAddress.getText());
		edec.getCoreFields().setForCity(textFieldForCity.getText());
		edec.getCoreFields().setForCountry(((CountryAndCode)comboBoxForCountry.getSelectedItem()).getCode());
		edec.getCoreFields().setForPhone(textFieldForPhone.getText());

	}
	
	public void saveToFile() { 
		DateFormat dateFormatter = new SimpleDateFormat("yyyyMMddHHmm");
		String filename = textFieldFilename.getText();
		if (filename.length()==0) { 
			filename = "edecFile_" + dateFormatter.format(new Date()) + ".txt";
		}
		File outputTarget = new File(filename);
		final JFileChooser fileChooser = new JFileChooser(outputTarget);
		fileChooser.setSelectedFile(outputTarget);
		int returnValue = fileChooser.showDialog(frame, "Save");
		if (returnValue == JFileChooser.APPROVE_OPTION) {
			File output = fileChooser.getSelectedFile();
			boolean ok = true;
			if (output.exists()) {
			    ok = false;
			    int result = JOptionPane.showConfirmDialog(frame, "File " + output.getName() + " exists.  Overwrite?", "File exists", JOptionPane.OK_CANCEL_OPTION);
			    ok = (result==JOptionPane.OK_OPTION);
			} 
			if (ok) { 
		        BufferedWriter file;
		        try { 
		        	file = new BufferedWriter(new FileWriter(output));	   
		        	file.write(edec.toEDecDocument());
		        	file.close();
		        } catch (IOException ex) {
		        	String message = ex.getMessage();
		        	if (ex.getCause()!=null) { 
		        		message = message + ex.getCause().getMessage();
		        	}
		        	JOptionPane.showMessageDialog(frame, "Unable to save.  " + ex.getMessage());
		        }
			}
		}
	}
	
	public void saveSpeciesToCSVFile() { 
		DateFormat dateFormatter = new SimpleDateFormat("yyyyMMddHHmm");
		String filename = "eDecSpecies_" + dateFormatter.format(new Date()) + ".csv";
		File outputTarget = new File(filename);
		final JFileChooser fileChooser = new JFileChooser(outputTarget);
		fileChooser.setSelectedFile(outputTarget);
		int returnValue = fileChooser.showDialog(frame, "Save");
		if (returnValue == JFileChooser.APPROVE_OPTION) {
			File output = fileChooser.getSelectedFile();
			boolean ok = true;
			if (output.exists()) {
			    ok = false;
			    int result = JOptionPane.showConfirmDialog(frame, "File " + output.getName() + " exists.  Overwrite?", "File exists", JOptionPane.OK_CANCEL_OPTION);
			    ok = (result==JOptionPane.OK_OPTION);
			} 
			if (ok) { 
		        BufferedWriter file;
		        try { 
		        	file = new BufferedWriter(new FileWriter(output));	 
		        	file.write(Species.CSVHEADERLINE);
		        	file.write(edec.toCSV());
		        	file.close();
		        } catch (IOException ex) {
		        	String message = ex.getMessage();
		        	if (ex.getCause()!=null) { 
		        		message = message + ex.getCause().getMessage();
		        	}
		        	JOptionPane.showMessageDialog(frame, "Unable to save.  " + ex.getMessage());
		        }
			}
		}
	}	
	
	protected void loadSpeciesFromCSVFile(boolean replaceExisting) {
		final JFileChooser fileChooser = new JFileChooser();
		fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int returnValue = fileChooser.showOpenDialog(frame);
		if (returnValue == JFileChooser.APPROVE_OPTION) {
			File file = fileChooser.getSelectedFile();
			if (file.canRead() && file.exists()) {
				if (replaceExisting) { 
				    edec.resetSpeciesFields();
				    table.setModel(new SpeciesTableModel(edec.getSpeciesFields()));
				} 
				try {
					BufferedReader stream = new BufferedReader (new FileReader(file));
					StringBuffer speciesText = new StringBuffer();
					String line = null;
					int lineCount = 0;
					while ( (line=stream.readLine()) != null ) {
						if (lineCount>0) {
							// skip header line
						    Species sp = Species.speciesCSVFactory(line);
						    edec.getSpeciesFields().add(sp);
						} 
						lineCount++;
					}
				} catch (IOException e1) {
					JOptionPane.showMessageDialog(frame,
						    "Problem reading file. " + e1.getMessage(),
						    "Error in reading file.",
						    JOptionPane.WARNING_MESSAGE);
				}
				((AbstractTableModel)table.getModel()).fireTableDataChanged();
			}
		}
		
	}	
	
	private void addPopup(Component component, final JPopupMenu popup) {
		component.addMouseListener(new MouseAdapter() {
			public void mousePressed(MouseEvent e) {
				if (e.isPopupTrigger()) {
					showMenu(e);
				}
			}
			public void mouseReleased(MouseEvent e) {
				if (e.isPopupTrigger()) {
					showMenu(e);
				}
			}
			private void showMenu(MouseEvent e) {
				popupPoint = e.getPoint();
				popup.show(e.getComponent(), e.getX(), e.getY());
			}
		});
	}
}
