import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cnpj_cpf_formatter/cnpj_cpf_formatter.dart';
import 'package:cnpj_cpf_helper/cnpj_cpf_helper.dart';
import 'package:flutter/services.dart';
import 'dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _form = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User user;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = User();
  }

  void _clearAll() {
    _formKey.currentState.reset();
    setState(() {
      nameController.clear();
      emailController.clear();
      cpfController.clear();
      cepController.clear();
      streetController.clear();
      numberController.clear();
      neighborhoodController.clear();
      cityController.clear();
      stateController.clear();
      countryController.clear();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cpfController.dispose();
    cepController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }

  void _buscaCEP(String cep, BuildContext ctx) async {
    var dio = Dio();

    try {
      var retorno = await dio.get('https://viacep.com.br/ws/$cep/json/');
      streetController.text = retorno.data['logradouro'];
      neighborhoodController.text = retorno.data['bairro'];
      cityController.text = retorno.data['localidade'];
      stateController.text = retorno.data['uf'];
      countryController.text = 'Brasil';
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: <Widget>[
              Icon(Icons.not_interested),
              SizedBox(width: 10),
              Text('Erro ao buscar as informações do CEP'),
            ],
          ),
        ),
      );
    }
  }

  void _dialogBox(BuildContext ctx) {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      showDialog(
          context: context,
          builder: (context) {
            return UsuarioDialog(user);
          });
    } else {
      Scaffold.of(ctx).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: <Widget>[
            Icon(Icons.error),
            SizedBox(width: 10),
            Text('Dados Inválidos, favor revisar!'),
          ],
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 100,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://instagram.fpoa7-2.fna.fbcdn.net/v/t51.2885-19/s150x150/97198572_290272431976937_5777047139892854784_n.jpg?_nc_ht=instagram.fpoa7-2.fna.fbcdn.net&_nc_ohc=OuTDBkv77BYAX87V3Ml&oh=d6797b694a2546e194055052859897df&oe=5F321594'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Full name',
                            border: OutlineInputBorder()),
                        validator: (name) {
                          if (name.length < 3)
                            return 'O nome deve conter mais do que 3 caracteres';
                          if (name.length > 30)
                            return 'O nome não deve conter mais do que 30 caracteres';
                          return null;
                        },
                        controller: nameController,
                        onSaved: (name) {
                          user.name = name;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (email) {
                          if (!EmailValidator.validate(email))
                            return 'Email inválido';
                          return null;
                        },
                        controller: emailController,
                        onSaved: (email) {
                          user.email = email;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'CPF', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (cpf) {
                          if (!CnpjCpfBase.isCpfValid(cpf))
                            return 'CPF inválido';
                          return null;
                        },
                        onSaved: (cpf) {
                          user.cpf = cpf;
                        },
                        inputFormatters: [
                          CnpjCpfFormatter(eDocumentType: EDocumentType.CPF)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 6,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'CEP',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (cep) {
                                  if (cep.length < 8)
                                    return 'O CEP deve conter 8 dígitos';
                                  return null;
                                },
                                controller: cepController,
                                onSaved: (cep) {
                                  user.cep = cep;
                                },
                              )),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 4,
                              child: Builder(builder: (ctx) {
                                return RaisedButton(
                                  onPressed: () {
                                    if (cepController.text.isNotEmpty) {
                                      _buscaCEP(cepController.text, ctx);
                                    }
                                  },
                                  child: Text('Buscar CEP'),
                                );
                              })),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 6,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Street',
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: streetController,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return 'O campo está vazio';
                                    if (value.length < 3)
                                      return 'Nome de rua muito curto';
                                    if (value.length > 30)
                                      return 'Nome de rua muito longo';
                                    return null;
                                  },
                                  onSaved: (value) {
                                    user.street = value;
                                  })),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Number',
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                validator: (numero) {
                                  if (int.tryParse(numero) == null)
                                    return 'Apenas números';
                                  return null;
                                },
                                onSaved: (value) {
                                  user.number = int.tryParse(value) as String;
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Neighborhood',
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: neighborhoodController,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return 'O campo está vazio';
                                    if (value.length < 3)
                                      return 'Nome de bairro muito curto';
                                    if (value.length > 30)
                                      return 'Nome de bairro muito longo';
                                    return null;
                                  },
                                  onSaved: (value) {
                                    user.neighborhood = value;
                                  })),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  border: OutlineInputBorder(),
                                ),
                                controller: cityController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'O campo está vazio';
                                  if (value.length < 3)
                                    return 'Nome de cidade muito curto';
                                  if (value.length > 30)
                                    return 'Nome de cidade muito longo';
                                  return null;
                                },
                                onSaved: (value) {
                                  user.city = value;
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'UF',
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: stateController,
                                  validator: (value) {
                                    if (value.length != 2) return 'UF';
                                    return null;
                                  },
                                  onSaved: (value) {
                                    user.state = value;
                                  })),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Country',
                                  border: OutlineInputBorder(),
                                ),
                                controller: countryController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'O campo está vazio';
                                  if (value.toUpperCase() != 'BRASIL')
                                    return 'Aqui é o Brasil';
                                  return null;
                                },
                                onSaved: (value) {
                                  user.country = value;
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: OutlineButton(
                  child: Text('Limpar'),
                  onPressed: () {
                    _clearAll();
                  },
                  textColor: Colors.red,
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 2,
                  child: Builder(
                    builder: (ctx) {
                      return OutlineButton(
                        child: Text('Cadastrar'),
                        textColor: Colors.teal,
                        onPressed: () => _dialogBox(ctx),
                        borderSide: BorderSide(color: Colors.teal),
                      );
                    },
                  ))
            ])
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  String email;
  String cpf;
  String cep;
  String street;
  String number;
  String neighborhood;
  String city;
  String state;
  String country = 'Brasil';
}
