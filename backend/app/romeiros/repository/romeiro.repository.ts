import { User } from '../models/User.model';
import { CreationAttributes } from 'sequelize';
import moment from 'moment-timezone';


class UserRepository {
    public async createUsers(users: CreationAttributes<User>[]): Promise<void> {
        try {
            const idUser = users[0]['idUser'];

            // Apaga todos os dados referentes àquele idUser
            await User.destroy({ where: { idUser: idUser } });
            console.log(`Dados para idUser ${idUser} deletados.`);

            // Obtém a data e hora atuais
            const currentDate = moment.tz('America/Belem').toDate();

            // Cria o array de usuários
            const usuarios = users.map(e => ({
                idUser: idUser,
                nome: e.nome,
                idade: e.idade,
                cidade: e.cidade,
                localDeAtendimento: e.localDeAtendimento,
                sexo: e.sexo,
                patologia: e.patologia,
                createdAt: e.createdAt || currentDate,
                updatedAt: e.updatedAt || currentDate
            }));

            // Adicionando usuários em lote
            await User.bulkCreate(usuarios);
            console.log(`Usuários para idUser ${idUser} criados com sucesso.`);
        } catch (error) {
            console.error('Erro ao criar ou atualizar usuários e romeiros:', error);
            throw new Error('Erro ao criar ou atualizar usuários e romeiros: ' + error);
        }
    }
}


// Exporta uma instância única do UserRepository
export default new UserRepository();
