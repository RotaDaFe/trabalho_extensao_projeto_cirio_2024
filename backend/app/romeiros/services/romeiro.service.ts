import UserRepository from '../repository/romeiro.repository'; // Importe o repositório
import { User } from '../models/User.model'
class UserService {
    // Create multiple users
    public async createMultipleUsers(users: User[]): Promise<void> {
        try {
            // Business logic: Validate or transform data if needed before saving to DB
            if (users.length === 0) {
                throw new Error("User list cannot be empty");
            }

            await UserRepository.createUsers(users);
        } catch (error) {
            throw new Error(`Error creating users: ${error}`);
        }
    }
}

export default new UserService();
