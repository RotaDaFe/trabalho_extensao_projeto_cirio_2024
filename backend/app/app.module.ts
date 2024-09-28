import 'dotenv/config';
import { Application } from 'express';
import express from 'express';
import sequelize from '../config/sequelize.config';
import { romeiroController } from "./romeiros/controllers/romeiro.controller"

export const AppModule = (app: Application) => {
    app.use(express.json());
    // Sincronização do Sequelize (cria tabelas se elas não existirem)
    sequelize.sync({ force: false }) // force: true recria as tabelas toda vez que reiniciar

    // API de exemplo
    app.use('/api', romeiroController);

};
