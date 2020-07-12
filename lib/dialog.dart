import 'package:flutter/material.dart';
import 'home_page.dart';

class UsuarioDialog extends StatelessWidget {
  final User user;

  UsuarioDialog(this.user);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Informações do usuário:'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Nome: '),
          Text('${user.name}'),
          SizedBox(height: 10),
          Text('Email: '),
          Text('${user.email}'),
          SizedBox(height: 10),
          Text('Cpf:'),
          Text('${user.cpf}'),
          SizedBox(height: 10),
          Text('Endereço:'),
          Text(
            '${user.street}, ${user.number}, Bairro ${user.neighborhood}, ${user.city} - ${user.state}. ${user.country} ',
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
  }
}
