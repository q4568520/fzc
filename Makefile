collect:
	@mkdir -p dist
	@rsync -a ./formulas/ ./dist/formulas/ --delete
	@rsync -a ./pillar/ ./dist/pillar/ --delete
	@if vagrant plugin list | grep vagrant-scp ; then echo "vagrant-scp installed"; else vagrant plugin install vagrant-scp; fi
	@vagrant ssh master -c "sudo chmod 777 /srv && sudo rm -rf /srv/*"
	@for salt_dir in $$(ls ./dist); do  vagrant scp ./dist/$${salt_dir} master:/srv/ > /dev/null; done
	@echo "Done!"
