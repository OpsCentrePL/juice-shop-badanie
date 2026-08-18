// DEFEKT SAST-03 | CWE-78 | oczekiwana faza 4
// Wstrzykniecie polecenia systemowego.
import { Request, Response } from 'express'
import { exec } from 'child_process'

export function archiveTool () {
  return (req: Request, res: Response) => {
    const plik = req.query.plik as string
    // celowo: parametr trafia do powloki systemowej
    exec('tar -czf /tmp/archiwum.tgz ' + plik, (err, stdout) => res.send(stdout || String(err)))
  }
}
