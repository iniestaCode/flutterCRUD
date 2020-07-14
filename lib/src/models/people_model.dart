import 'dart:convert';

PeopleModel peopleModelFromJson(String str) => PeopleModel.fromJson(json.decode(str));
String peopleModelToJson(PeopleModel data) => json.encode(data.toJson());
class PeopleModel {
    PeopleModel({
        this.id,
        this.titulo='',
        this.valor=0,
        this.disponible=true,
        this.fotoUrl,
    });
    String id;
    String titulo;
    int valor;
    bool disponible;
    String fotoUrl;
    factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        id        : json["id"],
        titulo    : json["titulo"],
        valor     : json["valor"],
        disponible: json["disponible"],
        fotoUrl   : json["fotoUrl"],
    );
    Map<String, dynamic> toJson() => {
        "titulo"    : titulo,
        "valor"     : valor,
        "disponible": disponible,
        "fotoUrl"   : fotoUrl,
    };
}
