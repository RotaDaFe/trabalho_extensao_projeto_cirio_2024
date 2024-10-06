import { Users, User } from '../models/User.model';
import { CreationAttributes, DataTypes, where } from 'sequelize';
import { Op } from 'sequelize';


class UserRepository {
    public async createUsers(users: CreationAttributes<User>[]): Promise<void> {
        try {
            // pega o id referente ao usuario
            const idUser = users[0]['idUser'];
            // apaga todos os dados referente aquele idUser
            User.destroy({ where: { idUser: idUser } })
            // criando array de usuarios
            var usuarios = users.map(e => {
                return {
                    idUser: idUser,
                    nome: e.nome,
                    idade: e.idade,
                    cidade: e.cidade,
                    localDeAtendimento: e.localDeAtendimento,
                    sexo: e.sexo,
                    patologia: e.patologia,
                    createdAt: e.createdAt,
                    updatedAt: e.updatedAt
                }
            })
            // adicionando usuarios em bash lote
            User.bulkCreate(usuarios);

        } catch (error) {
            throw new Error('Erro ao criar ou atualizar usuários e romeiros: ' + error);
        }
    }
}

// Exporta uma instância única do UserRepository
export default new UserRepository();
