/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.converters;

/**
 *
 * @author Karlitha
 */
import java.math.BigDecimal;
import java.math.RoundingMode;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;
import javax.faces.convert.FacesConverter;

import org.apache.commons.lang3.math.NumberUtils;

@FacesConverter("bigDecimalConverter")
public class BigDecimalConverter implements Converter {

    private static final BigDecimal UPPER_LIMIT = new BigDecimal(9999);
    private static final BigDecimal LOWER_LIMIT = new BigDecimal(-9999);

    @Override
    public Object getAsObject(FacesContext context, UIComponent component,
            String value) {
        if (!NumberUtils.isNumber(value)) {
            throw new ConverterException(new FacesMessage("not a number"));
        }
        if (value.contains(".")) {
            String decimalPlace = value.substring(value.indexOf("."));
        if (decimalPlace.length() > 3) { // 3 as decimal point is included in the String
                throw new ConverterException(new FacesMessage(
                        "too many numbers after decimal point"));
            }
        }
        BigDecimal convertedValue = new BigDecimal(value).setScale(2,
                RoundingMode.HALF_UP);
        if (convertedValue.compareTo(UPPER_LIMIT) > 0) {
            throw new ConverterException(new FacesMessage(
                    "value may not be greater than " + UPPER_LIMIT));
        }
        if (convertedValue.compareTo(LOWER_LIMIT) < 0) {
            throw new ConverterException(new FacesMessage(
                    "value may not be less than " + LOWER_LIMIT));
        }
        return convertedValue;
    }

    @Override
    public String getAsString(FacesContext context, UIComponent component,
            Object value) {
        return ((BigDecimal) value).toString();
    }
}
