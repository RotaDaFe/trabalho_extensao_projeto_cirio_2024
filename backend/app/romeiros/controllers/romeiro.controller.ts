import express, { Request, Response } from 'express';
import UserService from '../services/romeiro.service';
import dotenv from 'dotenv';


const router = express.Router();

// // GET /pacientes - Retorna todos os pacientes
// router.get('/pacientes', async (req: Request, res: Response) => {
//     try {
//         const pacientes = await UserService.getAllUsers();
//         res.status(200).json(pacientes); // Resposta com status 200 e lista de pacientes em formato JSON
//     } catch (error) {
//         console.log(error)
//         res.status(500).json({ error: error });
//     }
// });

// // GET /pacientes/:id - Retorna um paciente específico por ID
// router.get('/pacientes/:id', async (req: Request, res: Response) => {
//     try {
//         const pacienteId = parseInt(req.params.id);
//         const paciente = await UserService.getUserById(pacienteId);

//         if (!paciente) {
//             return res.status(404).json({ error: 'Paciente não encontrado' });
//         }

//         res.status(200).json(paciente);
//     } catch (error) {
//         res.status(500).json({ error: error });
//     }
// });

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
