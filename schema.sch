<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

    <sch:ns uri="http://example.com/nerv01/mobilni-katalog" prefix="mk"/>

    <sch:pattern>
        <sch:title>Kontrola základních údajů o telefonu</sch:title>
        <sch:rule context="mk:device">
            <sch:assert test="@id > 0">ID musí být kladné číslo!</sch:assert>
            <sch:report test="empty(mk:model/mk:name)">Element name musí obsahovat
                text!</sch:report>
            <sch:report test="empty(mk:model/mk:code)">Element code musí obsahovat
                text!</sch:report>
            <sch:report test="empty(mk:color)">Element color musí obsahovat text!</sch:report>
            <sch:assert test="mk:price > 0">Cena musí být kladné číslo!</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>Kontrola displaye</sch:title>
        <sch:rule context="mk:display">
            <sch:assert test="mk:size > 0">Úhlopříčka musí být kladné číslo!</sch:assert>
            <sch:assert test="mk:resolution/mk:width > 0">Šířka displaye musí být kladné
                číslo!</sch:assert>
            <sch:assert test="mk:resolution/mk:height > 0">Výška displaye musí být kladné
                číslo!</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>Kontrola baterie</sch:title>
        <sch:rule context="mk:battery">
            <sch:assert test="mk:size > 0">Velikost baterie musí být kladné číslo!</sch:assert>
            <sch:assert test="mk:charging/mk:wired > 0">Rychlost drátového nabíjení musí být kladné
                číslo!</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>Kontrola konstrukce</sch:title>
        <sch:rule context="mk:body">
            <sch:assert test="mk:dimensions/mk:height > 0">Výška musí být kladné číslo!</sch:assert>
            <sch:assert test="mk:dimensions/mk:width > 0">Šířka musí být kladné číslo!</sch:assert>
            <sch:assert test="mk:dimensions/mk:depth > 0">Tloušťka musí být kladné
                číslo!</sch:assert>
            <sch:assert test="mk:weight > 0">Výha musí být kladné číslo!</sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>
