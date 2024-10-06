import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from './../../../config/sequelize.config';

// Definição dos atributos do usuário
interface UserAttributes {
    id: number;
    idUser: string;
    nome: string;
    idade: number;
    cidade: string;
    localDeAtendimento: string;
    sexo: string;
    patologia: string;
    createdAt?: Date;
    updatedAt?: Date;
}

// Campos opcionais durante a criação de usuários (ID auto-incremento)
interface UserCreationAttributes extends Optional<UserAttributes, 'id'> { }

// Modelo de usuário com Sequelize
export class User extends Model<UserAttributes, UserCreationAttributes> implements UserAttributes {
    public id!: number;
    public idUser!: string;
    public nome!: string;
    public idade!: number;
    public cidade!: string;
    public localDeAtendimento!: string;
    public sexo!: string;
    public patologia!: string;
    public createdAt?: Date;
    public updatedAt?: Date;
}

// Definição do modelo no Sequelize
export const Users = User.init({
    id: {
        type: DataTypes.INTEGER.UNSIGNED,
        autoIncrement: true,
        primaryKey: true
    },
    idUser: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    nome: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    idade: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    cidade: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    localDeAtendimento: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    sexo: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    patologia: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    createdAt: {
        type: DataTypes.DATE,
        // defaultValue: DataTypes.NOW
    },
    updatedAt: {
        type: DataTypes.DATE,
        // defaultValue: DataTypes.NOW
    }
}, {
    sequelize,
    tableName: 'users',
    timestamps: true // Isso habilita os campos createdAt e updatedAt automaticamente
});

export default Users;
