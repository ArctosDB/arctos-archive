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

import java.util.ArrayList;
import java.util.List;

import javax.swing.table.AbstractTableModel;

import edu.harvard.mcz.edec.Species;

/**
 * Table model for displaying/editing a list of species lines for an eDec file.
 * 
 * @author mole
 *
 */
public class SpeciesTableModel extends AbstractTableModel {
	
	private List<Species> species;
	
	public static final int COLUMN_COUNTRY_OF_ORIGIN = 11;
	
	public SpeciesTableModel() { 
		species = new ArrayList<Species>();
	}

	public SpeciesTableModel(List<Species> speciesFields) {
		species = speciesFields;
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.TableModel#getRowCount()
	 */
	@Override
	public int getRowCount() {
		return species.size();
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.TableModel#getColumnCount()
	 */
	@Override
	public int getColumnCount() {
		return 12;
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.TableModel#getValueAt(int, int)
	 */
	@Override
	public Object getValueAt(int rowIndex, int columnIndex) {
		Object result = null;
		switch (columnIndex) { 
		case 0: 
			result = species.get(rowIndex).getGenus();
			break;
		case 1: 
			result = species.get(rowIndex).getSpecies();
			break;
		case 2: 
			result = species.get(rowIndex).getSubspecies();
			break;
		case 3: 
			result = species.get(rowIndex).getCommonName();
			break;
		case 4: 
			result = species.get(rowIndex).getForeignCITES();
			break;
		case 5: 
			result = species.get(rowIndex).getUSCITES();
			break;
		case 6: 
			result = species.get(rowIndex).getWildlifeCode();
			break;
		case 7: 
			result = species.get(rowIndex).getSourceCode();
			break;
		case 8: 
			result = species.get(rowIndex).getQuantity();
			break;
		case 9: 
			result = species.get(rowIndex).getUnits();
			break;
		case 10: 
			result = species.get(rowIndex).getValue();
			break;
		case COLUMN_COUNTRY_OF_ORIGIN: 
			result = species.get(rowIndex).getCountryOfOrigin();
			break;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.AbstractTableModel#getColumnName(int)
	 */
	@Override
	public String getColumnName(int column) {
		String result = super.getColumnName(column);
		switch (column) { 
		case 0: 
			result = "Generic";
			break;
		case 1: 
			result = "Specific";
			break;
		case 2: 
			result = "Subspecific";
			break;
		case 3: 
			result = "Common";
			break;
		case 4: 
			result = "Foreign CITES";
			break;
		case 5: 
			result = "US CITES";
			break;
		case 6: 
			result = "Description Code";
			break;
		case 7: 
			result = "Source";
			break;
		case 8: 
			result = "Quantity";
			break;
		case 9: 
			result = "Units";
			break;
		case 10: 
			result = "Value,USD";
			break;
		case COLUMN_COUNTRY_OF_ORIGIN: 
			result = "Country of Origin";
			break;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.AbstractTableModel#getColumnClass(int)
	 */
	@Override
	public Class<?> getColumnClass(int columnIndex) {
		switch (columnIndex) { 
		case 0: 
			return String.class;
		case 1: 
			return String.class;
		case 2: 
			return String.class;
		case 3: 
			return String.class;
		case 4: 
			return String.class;
		case 5: 
			return String.class;
		case 6: 
			return String.class;
		case 7: 
			return String.class;
		case 8: 
			return Integer.class;
		case 9: 
			return String.class;
		case 10: 
			return Integer.class;
		case 11: 
			return String.class;
		}
		return super.getColumnClass(columnIndex);
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.AbstractTableModel#isCellEditable(int, int)
	 */
	@Override
	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return true;
	}

	/* (non-Javadoc)
	 * @see javax.swing.table.AbstractTableModel#setValueAt(java.lang.Object, int, int)
	 */
	@Override
	public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
		switch (columnIndex) { 
		case 0: 
			species.get(rowIndex).setGenus(aValue.toString());
			break;
		case 1: 
			species.get(rowIndex).setSpecies(aValue.toString());
			break;
		case 2: 
			species.get(rowIndex).setSubspecies(aValue.toString());
			break;
		case 3: 
			species.get(rowIndex).setCommonName(aValue.toString());
			break;
		case 4: 
			species.get(rowIndex).setForeignCITES(aValue.toString());
			break;
		case 5: 
			species.get(rowIndex).setUSCITES(aValue.toString());
			break;
		case 6: 
			species.get(rowIndex).setWildlifeCode(aValue.toString());
			break;
		case 7: 
			species.get(rowIndex).setSourceCode(aValue.toString());
			break;
		case 8: 
			species.get(rowIndex).setQuantity(aValue.toString());
			break;
		case 9: 
			species.get(rowIndex).setUnits(aValue.toString());
			break;
		case 10: 
			species.get(rowIndex).setValue(aValue.toString());
			break;
		case COLUMN_COUNTRY_OF_ORIGIN: 
			species.get(rowIndex).setCountryOfOrigin(aValue.toString());
			break;
		}
		this.fireTableDataChanged();
	}
	
	public void addRow() { 
		species.add(new Species());
		this.fireTableDataChanged();
	}

	public void removeRow(int rowindex) {
		if (species.size()>rowindex) { 
		    species.remove(rowindex);
		    this.fireTableDataChanged();
		}
	}
	
}
