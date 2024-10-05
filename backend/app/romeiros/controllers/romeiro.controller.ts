import express, { Request, Response } from 'express';
import UserService from '../services/romeiro.service';
import dotenv from 'dotenv';


const router = express.Router();


router.post('/romeiros', async (req: Request, res: Response) => {
    try {
        const { romeiros, password } = req.body; // Recebe a lista de pacientes e a senha a partir do corpo da requisição
        // Obter a senha do arquivo .env
        const REQUIRED_PASSWORD = process.env.REQUIRED_PASSWORD;

        // Verifica se a senha foi fornecida e se está correta
        if (password !== REQUIRED_PASSWORD) {
            return res.status(403).json({ error: 'Senha inválida. Acesso negado.' });
        }

        // Verifica se "pacientes" é um array
        if (!Array.isArray(romeiros)) {
            return res.status(400).json({ error: 'O corpo da requisição deve ser uma lista de pacientes' });
        }

        // Cria os pacientes se a senha estiver correta
        await UserService.createMultipleUsers(romeiros);
        res.status(201).json({ message: 'Romeiros criados com sucesso' });
    } catch (error) {
        res.status(500).json({ error: error || error });
    }
});

export const romeiroController = router;
