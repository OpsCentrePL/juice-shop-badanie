// DEFEKT SAST-01 | CWE-89 | oczekiwana faza 4
// Wstrzykniecie kodu SQL przez konkatenacje parametru zapytania.
import { Request, Response } from 'express'
import { sequelize } from '../../models'

export function queryReport () {
  return (req: Request, res: Response) => {
    const kategoria = req.query.kategoria as string
    // celowo: parametr wstawiany bezposrednio do zapytania
    const sql = "SELECT id, name FROM Products WHERE category = '" + kategoria + "'"
    sequelize.query(sql).then(([wiersze]: any) => res.json(wiersze))
  }
}
